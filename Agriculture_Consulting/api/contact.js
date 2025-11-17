// Vercel Serverless Function for Agriculture Consulting Contact Form
// Handles form submissions and sends email notifications

export default async function handler(req, res) {
  // Only allow POST requests
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    // Parse request body (Vercel automatically parses JSON)
    const body = req.body || {};
    const { name, email, phone, message, website } = body;

    // Honeypot check - if this field is filled, it's likely a bot
    if (website && website.trim() !== '') {
      // Silently reject bot submissions
      return res.status(200).json({ success: true, message: 'Thank you for your message!' });
    }

    // Validate required fields
    if (!name || !email || !message) {
      return res.status(400).json({ error: 'All required fields must be filled' });
    }

    // Basic email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      return res.status(400).json({ error: 'Invalid email address' });
    }

    // Get email configuration from environment variables
    const recipientEmail = process.env.CONTACT_EMAIL || process.env.AGRI_CONTACT_EMAIL;
    const emailService = process.env.EMAIL_SERVICE || 'resend'; // 'resend', 'sendgrid', or 'nodemailer'

    if (!recipientEmail) {
      console.error('CONTACT_EMAIL or AGRI_CONTACT_EMAIL environment variable not set');
      return res.status(500).json({ error: 'Email configuration missing' });
    }

    // Prepare email content
    const subject = `New Contact Form Submission - Agriculture Consulting`;
    const phoneText = phone ? `Phone: ${phone}` : 'Phone: Not provided';
    const emailBody = `
New contact form submission from Agriculture Consulting website:

Name: ${name}
Email: ${email}
${phoneText}
Message:
${message}

---
This message was sent from the Agriculture Consulting contact form.
    `.trim();

    // Send email based on configured service
    let emailSent = false;

    if (emailService === 'resend') {
      emailSent = await sendWithResend(recipientEmail, subject, emailBody, { name, email, phone, message });
    } else if (emailService === 'sendgrid') {
      emailSent = await sendWithSendGrid(recipientEmail, subject, emailBody, { name, email, phone, message });
    } else {
      // Fallback: Use Resend as default
      emailSent = await sendWithResend(recipientEmail, subject, emailBody, { name, email, phone, message });
    }

    if (emailSent) {
      return res.status(200).json({ 
        success: true, 
        message: 'Thank you for your message! We\'ll get back to you within one business day.' 
      });
    } else {
      return res.status(500).json({ error: 'Failed to send email. Please try again later.' });
    }

  } catch (error) {
    console.error('Error processing contact form:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}

// Send email using Resend (recommended - free tier: 3,000 emails/month)
async function sendWithResend(recipientEmail, subject, body, formData) {
  const RESEND_API_KEY = process.env.RESEND_API_KEY;

  if (!RESEND_API_KEY) {
    console.error('RESEND_API_KEY environment variable not set');
    return false;
  }

  try {
    const response = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${RESEND_API_KEY}`,
      },
      body: JSON.stringify({
        from: process.env.RESEND_FROM_EMAIL || 'onboarding@resend.dev',
        to: recipientEmail,
        reply_to: formData.email,
        subject: subject,
        text: body,
        html: `
          <h2>New Contact Form Submission</h2>
          <p><strong>Name:</strong> ${formData.name}</p>
          <p><strong>Email:</strong> ${formData.email}</p>
          ${formData.phone ? `<p><strong>Phone:</strong> ${formData.phone}</p>` : ''}
          <p><strong>Message:</strong></p>
          <p>${formData.message.replace(/\n/g, '<br>')}</p>
          <hr>
          <p><em>This message was sent from the Agriculture Consulting contact form.</em></p>
        `,
      }),
    });

    if (!response.ok) {
      const errorData = await response.text();
      console.error('Resend API error:', errorData);
      return false;
    }

    return true;
  } catch (error) {
    console.error('Error sending email with Resend:', error);
    return false;
  }
}

// Send email using SendGrid
async function sendWithSendGrid(recipientEmail, subject, body, formData) {
  const SENDGRID_API_KEY = process.env.SENDGRID_API_KEY;

  if (!SENDGRID_API_KEY) {
    console.error('SENDGRID_API_KEY environment variable not set');
    return false;
  }

  try {
    const response = await fetch('https://api.sendgrid.com/v3/mail/send', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SENDGRID_API_KEY}`,
      },
      body: JSON.stringify({
        personalizations: [{
          to: [{ email: recipientEmail }],
          reply_to: { email: formData.email },
        }],
        from: { 
          email: process.env.SENDGRID_FROM_EMAIL || 'noreply@example.com',
          name: 'Agriculture Consulting Contact Form'
        },
        subject: subject,
        content: [
          {
            type: 'text/plain',
            value: body,
          },
          {
            type: 'text/html',
            value: `
              <h2>New Contact Form Submission</h2>
              <p><strong>Name:</strong> ${formData.name}</p>
              <p><strong>Email:</strong> ${formData.email}</p>
              ${formData.phone ? `<p><strong>Phone:</strong> ${formData.phone}</p>` : ''}
              <p><strong>Message:</strong></p>
              <p>${formData.message.replace(/\n/g, '<br>')}</p>
              <hr>
              <p><em>This message was sent from the Agriculture Consulting contact form.</em></p>
            `,
          },
        ],
      }),
    });

    if (!response.ok) {
      const errorData = await response.text();
      console.error('SendGrid API error:', errorData);
      return false;
    }

    return true;
  } catch (error) {
    console.error('Error sending email with SendGrid:', error);
    return false;
  }
}


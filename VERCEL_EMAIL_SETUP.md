# Vercel Email Setup Guide

This guide will help you configure email functionality for your contact forms using Vercel serverless functions.

## Overview

Your contact forms now use Vercel serverless functions located at:
- `AI_Consulting/api/contact.js`
- `Agriculture_Consulting/api/contact.js`

These functions handle form submissions and send email notifications. You need to configure an email service to make them work.

## Step 1: Choose an Email Service

### Option A: Resend (Recommended) ⭐

**Why Resend?**
- Free tier: 3,000 emails/month
- Easy setup
- Great developer experience
- Fast delivery

**Setup Steps:**
1. Go to [resend.com](https://resend.com) and sign up
2. Verify your email address
3. Go to **API Keys** in the dashboard
4. Click **Create API Key**
5. Copy the API key (starts with `re_...`)
6. Go to **Domains** and add your domain (or use the default `onboarding@resend.dev` for testing)

### Option B: SendGrid

**Why SendGrid?**
- Free tier: 100 emails/day
- Enterprise-grade
- More features

**Setup Steps:**
1. Go to [sendgrid.com](https://sendgrid.com) and sign up
2. Verify your email
3. Go to **Settings → API Keys**
4. Click **Create API Key**
5. Give it a name and select **Full Access** or **Restricted Access** (Mail Send permission)
6. Copy the API key

## Step 2: Configure Environment Variables in Vercel

For each Vercel project (AI Consulting and Agriculture Consulting), you need to add environment variables:

### For AI Consulting Project:

1. Go to your Vercel dashboard
2. Select the **AI Consulting** project
3. Go to **Settings → Environment Variables**
4. Add the following variables:

#### If using Resend:
```
RESEND_API_KEY = re_xxxxxxxxxxxxx
RESEND_FROM_EMAIL = your-email@yourdomain.com (or onboarding@resend.dev for testing)
AI_CONTACT_EMAIL = your-email@example.com (where you want to receive form submissions)
EMAIL_SERVICE = resend
```

#### If using SendGrid:
```
SENDGRID_API_KEY = SG.xxxxxxxxxxxxx
SENDGRID_FROM_EMAIL = your-email@yourdomain.com
AI_CONTACT_EMAIL = your-email@example.com
EMAIL_SERVICE = sendgrid
```

### For Agriculture Consulting Project:

1. Go to your Vercel dashboard
2. Select the **Agriculture Consulting** project
3. Go to **Settings → Environment Variables**
4. Add the following variables:

#### If using Resend:
```
RESEND_API_KEY = re_xxxxxxxxxxxxx
RESEND_FROM_EMAIL = your-email@yourdomain.com
AGRI_CONTACT_EMAIL = your-email@example.com (where you want to receive form submissions)
EMAIL_SERVICE = resend
```

#### If using SendGrid:
```
SENDGRID_API_KEY = SG.xxxxxxxxxxxxx
SENDGRID_FROM_EMAIL = your-email@yourdomain.com
AGRI_CONTACT_EMAIL = your-email@example.com
EMAIL_SERVICE = sendgrid
```

### Shared Variables (Optional)

If both sites should send to the same email, you can use:
```
CONTACT_EMAIL = your-email@example.com
```

This will be used if `AI_CONTACT_EMAIL` or `AGRI_CONTACT_EMAIL` is not set.

## Step 3: Redeploy Your Projects

After adding environment variables:

1. Go to each project in Vercel
2. Click **Deployments**
3. Click the **⋯** menu on the latest deployment
4. Click **Redeploy**
5. Or simply push a new commit to trigger automatic deployment

## Step 4: Test Your Forms

1. Visit your deployed site
2. Fill out the contact form
3. Submit it
4. Check your email inbox for the notification

## Troubleshooting

### Forms show "Failed to send email"

**Check:**
1. Environment variables are set correctly in Vercel
2. API key is valid and not expired
3. From email is verified in your email service
4. Check Vercel function logs: **Deployments → Function Logs**

### No email received

**Check:**
1. Check spam/junk folder
2. Verify the recipient email address is correct
3. Check email service dashboard for delivery status
4. Verify your domain is authenticated (for custom domains)

### "Email configuration missing" error

**Solution:**
- Make sure `CONTACT_EMAIL`, `AI_CONTACT_EMAIL`, or `AGRI_CONTACT_EMAIL` is set
- Redeploy after adding environment variables

### Function logs show API errors

**Common issues:**
- **Resend**: Make sure your domain is verified or use `onboarding@resend.dev` for testing
- **SendGrid**: Verify sender email address in SendGrid dashboard
- **Rate limits**: Check if you've exceeded free tier limits

## Environment Variables Reference

| Variable | Required | Description | Example |
|----------|----------|-------------|---------|
| `RESEND_API_KEY` | Yes (if using Resend) | Your Resend API key | `re_abc123...` |
| `SENDGRID_API_KEY` | Yes (if using SendGrid) | Your SendGrid API key | `SG.abc123...` |
| `RESEND_FROM_EMAIL` | Yes (if using Resend) | Sender email address | `noreply@yourdomain.com` |
| `SENDGRID_FROM_EMAIL` | Yes (if using SendGrid) | Sender email address | `noreply@yourdomain.com` |
| `AI_CONTACT_EMAIL` | Recommended | Where AI Consulting forms send to | `you@example.com` |
| `AGRI_CONTACT_EMAIL` | Recommended | Where Agriculture Consulting forms send to | `you@example.com` |
| `CONTACT_EMAIL` | Fallback | Used if site-specific email not set | `you@example.com` |
| `EMAIL_SERVICE` | Optional | Email service to use (`resend` or `sendgrid`) | `resend` |

## Security Notes

✅ **Already implemented:**
- Honeypot fields (bot protection)
- Input validation
- Email format validation
- CORS protection (Vercel handles this)

🔒 **Best practices:**
- Never commit API keys to git
- Use environment variables for all sensitive data
- Regularly rotate API keys
- Monitor email service usage

## Next Steps

1. ✅ Set up email service account (Resend or SendGrid)
2. ✅ Add environment variables in Vercel
3. ✅ Redeploy both projects
4. ✅ Test contact forms
5. ✅ Verify emails are received
6. ✅ (Optional) Set up custom domain for email sending

## Support

- **Resend Docs**: https://resend.com/docs
- **SendGrid Docs**: https://docs.sendgrid.com
- **Vercel Functions**: https://vercel.com/docs/functions
- **Vercel Environment Variables**: https://vercel.com/docs/concepts/projects/environment-variables


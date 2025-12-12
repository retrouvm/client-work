// API route for uploading videos to Vercel Blob
// This allows you to upload videos and get public URLs

import { put } from '@vercel/blob';

export const config = {
  api: {
    bodyParser: {
      sizeLimit: '100mb', // Adjust based on your needs
    },
  },
};

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { filename, file } = req.body;

    if (!filename || !file) {
      return res.status(400).json({ error: 'Filename and file are required' });
    }

    // Upload to Vercel Blob
    const blob = await put(filename, file, {
      access: 'public',
      addRandomSuffix: false, // Keep original filename
    });

    return res.status(200).json({ url: blob.url });
  } catch (error) {
    console.error('Error uploading video:', error);
    return res.status(500).json({ error: 'Failed to upload video' });
  }
}


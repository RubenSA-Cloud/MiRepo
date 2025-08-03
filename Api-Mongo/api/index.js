const express = require('express');
const { MongoClient } = require('mongodb');

const app = express();
const PORT = 3000;
const MONGO_URL = 'mongodb://mongo:27017';
const DB_NAME = 'test';

app.get('/', async (req, res) => {
  const client = new MongoClient(MONGO_URL);
  try {
    await client.connect();
    const db = client.db(DB_NAME);
    const count = await db.collection('visits').countDocuments();
    await db.collection('visits').insertOne({ timestamp: new Date() });
    res.send(`Visit count: ${count + 1}`);
  } catch (e) {
    res.status(500).send('Error connecting to MongoDB');
  } finally {
    await client.close();
  }
});

app.listen(PORT, () => {
  console.log(`API listening on port ${PORT}`);
});


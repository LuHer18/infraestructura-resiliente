const express = require('express');
const os = require('os');

const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.json({
    message: 'API funcionando correctamente',
    hostname: os.hostname(),
    timestamp: new Date().toISOString()
  });
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'UP' });
});

app.get('/cpu', (req, res) => {
  const end = Date.now() + 5000;
  while (Date.now() < end) {
    Math.random() * Math.random();
  }
  res.json({ message: 'Carga CPU generada' });
});

app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});
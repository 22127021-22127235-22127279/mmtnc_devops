const express = require('express');

const app = express();

app.get('/', (req, res) => {
    res.send('Chao thay Son <3!');
});

const PORT = 5000;

app.listen(PORT, () => {
    console.log(`Server started on port ${PORT}`);
});

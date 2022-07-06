const express = require('express');
const app = express();

// middlewares
app.use(express.json());
app.use(express.urlencoded({extended: false}));

// routes
app.use(require('./routes/index'));

/*app.listen(3000);
console.log('Server on port 3000');*/

var port = process.env.PORT || 3000;
app.listen(port);
console.log('Products API starting on port : ' + port); // Mensaje de inicio de servicio

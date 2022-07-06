const {Router} = require('express');
const router = Router();

const { getProducts } = require('../controllers/index.controller');

router.get('/products', getProducts);

/*router.get('/products', (req, res) => {
    res.send('products');
})*/

module.exports = router;

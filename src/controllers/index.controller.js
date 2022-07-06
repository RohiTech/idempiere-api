const { Pool } = require('pg');

const pool = new Pool({
    host: "localhost",
    user: "adempiere",
    password: "adempiere",
    database: "idempiere",
    port: 5432
});

const getProducts = async (req, res) => {
    const response = await pool.query('select * from rep_leftoverstockproduct();');
    res.json(response.rows);
    /*console.log(response.rows);
    res.send('products');*/
}

/*const getProducts = (req, res) => {
    res.send('products');
}*/

module.exports = {
    getProducts
}
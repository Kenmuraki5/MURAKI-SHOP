const pool = require("../config/db.config");
const jwt = require('jsonwebtoken');

async function isLoggedIn(req, res, next) {
    let authorization = req.headers.authorization
    if (!authorization) {
        return res.status(401).send('You are not logged in')
    }

    let [part1, part2] = authorization.split(' ')
    if (part1 !== 'Bearer' || !part2) {
        return res.status(401).send('You are not logged in')
    }

    // Check token
    const [tokens_c] = await pool.query('SELECT * FROM tokens_c WHERE token = ?', [part2])
    const [tokens_a] = await pool.query('SELECT * FROM tokens_a WHERE token = ?', [part2])
    const token_c = tokens_c[0]
    const token_a = tokens_a[0]
    if (!token_c && !token_a) {
        return res.status(401).send('You are not logged in')
    }
    if(token_c){
        const [user1] = await pool.query(
            'SELECT * FROM Customer WHERE customer_id = ?', [token_c.user_id]
        )
        user1[0].type = "customer"
        req.user = user1[0];
    }
    else if(token_a){
        const [user2] = await pool.query(
            'SELECT * FROM Admin WHERE admin_id = ?', [token_a.user_id]
        )
        user2[0].type = "admin"
        req.user = user2[0];
    }
    // Set user
    // req.user = jwt.verify(part2, "miraki");
    next()
}

module.exports = {
    isLoggedIn
}
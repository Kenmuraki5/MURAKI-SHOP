const express = require("express");
const path = require("path")
const pool = require("../config/db.config");

router = express.Router();
const multer = require('multer')
// SET STORAGE
var storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, './static/uploads')
  },
  filename: function (req, file, callback) {
    callback(null, file.originalname)
  }
})
const upload = multer({ storage: storage })

router.get("/CheckOut", async function (req, res, next) {
  try {
    let result = await pool.query("SELECT * FROM `Shipping_Method`");
    res.send(result[0])
    console.log(result[0])
  } catch (err) {
    return next(err)
  }
});

router.post("/addPayment", upload.single('image'), async function (req, res, next) {
  const conn = await pool.getConnection()
  console.log(req.body.shipping)
  try {
    const cart = JSON.parse(req.body.cart)
    
    await conn.beginTransaction();
    

    let addOrder = await conn.query("INSERT INTO cust_order \
    (order_date, customer_id, shipping_id, address, total_price, status_value) value(current_timestamp(),?,?,'blank',?,'pending')",
      [req.body.customer_id, req.body.shipping, req.body.totalPrice]);
    cart.forEach(item => {
      let addOrderLine =  conn.query('insert into order_line (order_id, isbn, quantity, price) value (?,?,?,?)',
    [addOrder[0].insertId, item.isbn, item.quantity, item.quantity*item.book_price])
    });
     
    let addSlip = await conn.query('insert into payment (order_id, payment_status, slip_img) value (?,?,?)',
    [addOrder[0].insertId, 'pending', req.file.filename])

    await conn.commit()
    res.json("success!")
  }
  catch (err) {
    await conn.rollback();
    next(err)
  }
  finally {
    console.log('finally')
    conn.release();
  }
});


exports.router = router;
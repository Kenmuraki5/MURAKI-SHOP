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
  try {
    console.log(JSON.parse(req.body.cart))
    console.log(req.file.filename)
    let result = await pool.query("INSERT INTO cust_order \
    (order_date, customer_id, shipping_id, address, total_price, status_value) value(current_timestamp(),?,?,'blank',?,'pending')",
    [req.body.customer_id, req.body.shipping,req.body.totalPrice]);
    
    res.send("sucuss")
    // res.send(result[0])
    // console.log(result[0])
  } catch (err) {
    return next(err)
  }
});


exports.router = router;
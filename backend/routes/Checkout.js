const express = require("express");
const path = require("path")
const pool = require("../config/db.config");
const { isLoggedIn } = require('../middlewares/index')

router = express.Router();
const multer = require('multer');
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
    // if(!req.query.cart){
    //   return res.status(400).send("None product in cart");
    // }
    let result = await pool.query("SELECT * FROM Shipping_Method");
    let instock = await pool.query('SELECT isbn, in_stock from Book')
    for (let incart of req.query.cart) {
      let matchingBook = instock[0].find(book => book.isbn === incart.isbn);
      if (matchingBook && incart.quantity > matchingBook.in_stock) {
        return res.status(400).send("Quantity exceeds available stock");
      }
    }
    res.send(result[0])
  } catch (err) {
    return next(err)
  }
});

router.post("/addPayment", isLoggedIn, upload.single('image'), async function (req, res, next) {
  const conn = await pool.getConnection()
  try {
    const cart = JSON.parse(req.body.cart)
    if (cart.length == 0) {
      return res.status(400).send("None product in cart.")
    }
    for (const item of cart) {
      const [checkstock] = await pool.query("SELECT in_stock, book_name FROM Book WHERE isbn=?", [item.isbn])
      if (item.quantity > checkstock[0].in_stock) {
        return res.status(409).send(`${item.book_name} is out of stock.`)
      }
    }
    await conn.beginTransaction();

    if (req.user.type == "customer") {
      let addOrder = await conn.query("INSERT INTO Cust_Order \
    (order_date, customer_id, shipping_id, address, total_price, status_value) value(current_timestamp(),?,?,?,?,'pending')",
        [req.user.customer_id, req.body.shipping, req.body.address, req.body.totalPrice]);
      cart.forEach(item => {
        let addOrderLine = conn.query('INSERT into Order_Line (order_id, isbn, quantity, price, book_name, book_img) \
        value (?,?,?,?,?,?)',
          [addOrder[0].insertId, item.isbn, item.quantity, item.quantity * item.book_price, item.book_name, item.book_img])
        let updateBook = conn.query('update Book set in_stock = in_stock - ? where isbn = ?',
          [item.quantity, item.isbn])
      });

      let addSlip = await conn.query('INSERT into Payment (order_id, payment_status, slip_img) value (?,?,?)',
        [addOrder[0].insertId, 'pending', req.file.filename])
    }
    else if(req.user.type == "admin"){
      return res.status(409).send("You are not customer")
    }


    conn.commit()
    res.json("success!")
  }
  catch (err) {
    conn.rollback();
    next(err)
  }
  finally {
    console.log('finally')
    conn.release();
  }
});


exports.router = router;
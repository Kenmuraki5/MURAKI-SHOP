const express = require("express");
const pool = require("../config/db.config");
const jwt = require('jsonwebtoken');
const argon2 = require('argon2');
router = express.Router();
// Require multer for file upload
const multer = require('multer');
const { isLoggedIn } = require("../middlewares");


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

router.get("/verifyuser", isLoggedIn, async function (req, res, next) {
  try {
    if (await argon2.verify(req.user.c_password || req.user.a_password, req.query.password)) {
      res.send(true)
    }
    else {
      res.send(false)
    }
  } catch (error) {
    res.status(500).json(err);
  }
});

router.put("/EditProfile", isLoggedIn, async function (req, res, next) {
  const conn = await pool.getConnection()
  await conn.beginTransaction()
  try {
    if (req.user.type == 'customer') {
      await conn.query(`UPDATE CUSTOMER SET c_username = ?, c_first_name = ?, c_last_name = ?,\
    c_address = ?, c_email = ?, c_phone = ? where customer_id = ?`, [req.body.username, req.body.fname,
      req.body.lname, req.body.address, req.body.email, req.body.phonenumber, req.user.customer_id]);
      const [customer] = await conn.query(`select * from customer  where customer_id = ${req.user.customer_id}`)
      customer[0].type = "customer"
      const secretKey = "miraki";
      token = jwt.sign(customer[0], secretKey, { algorithm: 'HS256' });
      await conn.query(
        'update tokens set token = ? where user_id = ?',
        [token, customer[0].customer_id]
      )
      conn.commit()
      console.log("success")
      res.send(token)
    }
    else if (req.user.type == 'admin') {
      await conn.query(`UPDATE admin SET a_username = ?, a_first_name = ?, a_last_name = ?,\
    a_address = ?, a_email = ?, a_phone = ? where admin_id = ?`, [req.body.username, req.body.fname,
      req.body.lname, req.body.address, req.body.email, req.body.phonenumber, req.user.admin_id]);
      const [admin] = await conn.query(`select * from admin where admin_id = ${req.user.admin_id}`)
      admin[0].type = "admin"
      const secretKey = "miraki";
      token = jwt.sign(admin[0], secretKey, { algorithm: 'HS256' });
      await conn.query(
        'update tokens set token = ? where user_id = ?',
        [token, admin[0].admin_id,]
      )
      conn.commit()
      console.log("success")
      res.send(token)
    }
  } catch (err) {
    conn.rollback()
    return next(err)
  } finally{
    conn.release()
    console.log("finally")
  }
});

router.put("/changepicture", isLoggedIn, upload.single('img'), async function (req, res, next) {
  const conn = await pool.getConnection()
  await conn.beginTransaction()
  try {
    const file = req.file;
    if (req.user.type == 'customer') {
      await conn.query(`UPDATE CUSTOMER SET c_image = ? where customer_id = ?`, [file.filename, req.user.customer_id])
      const [customer] = await conn.query(`select * from customer  where customer_id = ${req.user.customer_id}`)
      customer[0].type = "customer"
      const secretKey = "miraki";
      token = jwt.sign(customer[0], secretKey, { algorithm: 'HS256' });
      await conn.query(
        'update tokens set token = ? where user_id = ?',
        [token, customer[0].customer_id]
      )
      conn.commit()
      console.log("success")
      res.send(token)
    }
    if (req.user.type == 'admin') {
      await conn.query(`UPDATE admin SET a_image = ? where admin_id = ?`, [file.filename, req.body.admin_id])
      const [admin] = await conn.query(`select * from admin where admin_id = ${req.user.admin_id}`)
      admin[0].type = "admin"
      const secretKey = "miraki";
      token = jwt.sign(admin[0], secretKey, { algorithm: 'HS256' });
      await conn.query(
        'update tokens set token = ? where user_id = ?',
        [token, admin[0].admin_id,]
      )
      conn.commit()
      console.log("success")
      res.send(token)
    }

  } catch (err) {
    conn.rollback()
    return next(err)
  } finally {
    conn.release()
    console.log("finally")
  }
});
exports.router = router;
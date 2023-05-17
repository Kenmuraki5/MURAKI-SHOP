const express = require("express");
const pool = require("../config/db.config");
const jwt = require('jsonwebtoken');
const Joi = require('joi');
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
    res.status(400).json(error);
  }
});

const usernameValidator = async (value, helpers) => {
  const [customer, _] = await pool.query("select c_username from Customer where c_username = ?", [value])
  const [admin] = await pool.query(`select a_username from Admin where a_username = ?`, [value])
  if (customer.length > 0 || admin.length > 0) {
    const message = 'This username is already taken'
    throw new Joi.ValidationError(message, { message })
    // throw new Joi.ValidationError('This username is already taken')
  }
  return value
}

const signupSchema = Joi.object({
  username: Joi.string().optional().min(5).max(20).external(usernameValidator),
  phonenumber: Joi.string().required().pattern(/0[0-9]{9}/),
  fname: Joi.string().required().max(150),
  lname: Joi.string().required().max(150),
  address: Joi.string().required(),
})

router.put("/EditProfile", isLoggedIn, async function (req, res, next) {
  const conn = await pool.getConnection()
  await conn.beginTransaction()
  
  try {
    if (req.body.username && req.user.type == "customer"){
      const [check_customer] = await conn.query("select * from customer where customer_id = ? and c_username = ?", [req.user.customer_id, req.body.username])
      if(check_customer[0]){
        delete req.body.username
      }
    }
    else if (req.body.username && req.user.type == "admin"){
      const [check_username] = await conn.query("select * from customer where admin_id = ? and a_username = ?", [req.user.admin_id, req.body.username])
      if(check_username[0]){
        delete req.body.username
      }
    }
    await signupSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    console.log(err.message)
    return res.status(400).send(err.message)
  }

  try {
    const secretKey = "miraki";
    let token
    if (req.user.type == 'customer') {
      
      await conn.query(`UPDATE CUSTOMER SET c_first_name = ?, c_last_name = ?,\
    c_address = ?, c_phone = ? where customer_id = ?`, [req.body.fname,
      req.body.lname, req.body.address, req.body.phonenumber, req.user.customer_id]);
    
      if(req.body.username){
        await conn.query(`UPDATE CUSTOMER SET c_username = ? where customer_id = ?`, [req.body.username, req.user.customer_id]);
        
        const [customer] = await conn.query(`select customer_id from customer  where customer_id = ?`,
        [req.user.customer_id])
        customer[0].type = "customer"
        token = jwt.sign(customer[0], secretKey, { algorithm: 'HS256' });
        await conn.query(
          'update tokens_c set token = ? where user_id = ?',
          [token,req.user.customer_id,]
        )
      }
      conn.commit()
      console.log("update success")
      res.json({status:"update success", token:token || ""})
    }
    else if (req.user.type == 'admin') {
      await conn.query(`UPDATE admin SET a_first_name = ?, a_last_name = ?,\
    a_address = ?, a_phone = ? where admin_id = ?`, [req.body.fname,
      req.body.lname, req.body.address, req.body.phonenumber, req.user.admin_id]);

      if(req.body.username){
        await conn.query(`UPDATE CUSTOMER SET a_username = ? where admin_id = ?`, [req.body.username, req.user.admin_id]);
        
        const [admin] = await conn.query(`select admin_id from admin  where admin_id = ?`,
        [req.user.admin_id])
        admin[0].type = "admin"
        token = jwt.sign(admin[0], secretKey, { algorithm: 'HS256' });
      }
      conn.commit()
      console.log("update success")
      res.json({status:"update success", token:token||""})
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

      conn.commit()
      console.log("success")
      res.status(200).send("update success")
    }
    if (req.user.type == 'admin') {
      await conn.query(`UPDATE admin SET a_image = ? where admin_id = ?`, [file.filename, req.user.admin_id])

      conn.commit()
      console.log("success")
      res.status(200).send("update success")
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
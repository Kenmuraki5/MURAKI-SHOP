const express = require("express");
const pool = require("../config/db.config");
const Joi = require('joi');
const argon2 = require('argon2');
const jwt = require('jsonwebtoken');
const { isLoggedIn } = require('../middlewares/index')
const nodemailer = require('nodemailer');
router = express.Router();

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

const passwordValidator = (value, helpers) => {
  if (value.length < 8) {
    throw new Joi.ValidationError('Password must contain at least 8 characters')
  }
  if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
    throw new Joi.ValidationError('Password must be harder')
  }
  return value
}

const emailValidator = async (value, helpers) => {
  const [customer, _] = await pool.query("select c_email from Customer where c_email = ?", [value])
  const [admin] = await pool.query(`select a_email from Admin where a_email = ?`, [value])
  if (customer.length > 0 || admin.length > 0) {
    throw new Joi.ValidationError('This email is already taken')
  }
  return value
}

const signupSchema = Joi.object({
  username: Joi.string().required().min(5).max(20).external(usernameValidator),
  password: Joi.string().required().custom(passwordValidator),
  confirm_password: Joi.string().required().valid(Joi.ref('password')),
  email: Joi.string().required().external(emailValidator),
  phonenumber: Joi.string().required().pattern(/0[0-9]{9}/),
  fname: Joi.string().required().max(150),
  lname: Joi.string().required().max(150),
  address: Joi.string().required(),
})

router.post("/register", async function (req, res, next) {
  try {
    console.log(req.body)
    await signupSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    console.log(err.message)
    return res.status(400).send(err.message)
  }
  const username = req.body.username
  const password = await argon2.hash(req.body.password)
  const confirm_password = req.body.confirm_password
  const first_name = req.body.fname
  const last_name = req.body.lname
  const address = req.body.address
  const email = req.body.email
  const mobile = req.body.phonenumber
  try {
    if (!await argon2.verify(password, confirm_password)) {
      throw new Error('confirm password not match password')
    }
    await pool.query('INSERT INTO `Customer`(`c_username`, `c_password`, `c_first_name`, `c_last_name`, `c_address`, `c_email`, `c_phone`, `c_image`) \
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [username, password, first_name, last_name, address, email, mobile, ""]);
    res.send("add success")
  } catch (err) {
    res.status(400).json(err.toString());
  }
});

const loginSchema = Joi.object({
  username: Joi.string().required(),
  password: Joi.string().required()
})
router.post("/signin", async function (req, res, next) {
  try {
    //ตรวจสอบความถูกต้องของข้อมูลด้วยคำสั่ง validate()
    await loginSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    return res.status(400).json(err.toString())
  }

  const username = req.body.username
  const password = req.body.password

  const conn = await pool.getConnection()
  await conn.beginTransaction()
  try {
    const [customers] = await conn.query(
      'SELECT * FROM Customer WHERE (c_username = ? or c_email = ?)',
      [username, username]
    )
    const [admins] = await conn.query(
      'SELECT * FROM Admin WHERE (a_username = ? or a_email = ?)',
      [username, username]
    )
    const customer = customers[0] == undefined ? "" : customers[0]
    const admin = admins[0] == undefined ? "" : admins[0]
    // Check if username is correct
    if (!customer && !admin) {
      throw new Error('Incorrect username or password')
    }
    // Check if password is correct
    if (customer && await argon2.verify(customer.c_password, password)) {
      customer.type = "customer"
      const [tokens] = await conn.query(
        'SELECT * FROM tokens_c WHERE user_id=?',
        [customer.customer_id]
      )
      // Check if token already existed
      let token = tokens[0]?.token
      if (!token) {
        const secretKey = "miraki";
        // Generate and save token into database
        token = jwt.sign(customer, secretKey, { algorithm: 'HS256' });
        await conn.query(
          'INSERT INTO tokens_c(user_id, token) VALUES (?, ?)',
          [customer.customer_id, token]
        )
      }
      conn.commit()
      res.status(200).json({ 'token': token })
    }
    else if (admin && await argon2.verify(admin.a_password, password)) {
      admin.type = "admin"
      const [tokens] = await conn.query(
        'SELECT * FROM tokens_a WHERE user_id=?',
        [admin.admin_id]
      )
      // Check if token already existed
      let token = tokens[0]?.token
      if (!token) {
        const secretKey = "miraki";
        // Generate and save token into database
        token = jwt.sign(admin, secretKey, { algorithm: 'HS256' });
        await conn.query(
          'INSERT INTO tokens_a(user_id, token) VALUES (?, ?)',
          [admin.admin_id, token]
        )
      }
      conn.commit()
      res.status(200).json({ 'token': token })
    }
    else {
      throw new Error('Incorrect username or password')
    }

  } catch (error) {
    conn.rollback()
    res.status(400).json(error.toString())
  } finally {
    conn.release()
  }
});
router.post("/forgot-password",function(req, res, next){
  var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'murakishopp@gmail.com',
      pass: 'fjtwhzpyfvwiktrv'
    }
  });
  
  var mailOptions = {
    from: 'murakishopp@gmail.com',
    to: req.body.email,
    subject: 'Password Reset',
    text: 'That was easy!'
  };
  transporter.sendMail(mailOptions, function(error, info){
    if (error) {
      console.log(error);
      res.status(400).send("error")
    } else {
      console.log('Email sent: ' + info.response);
      res.send("success")
    }
  });
  // console.log(req.body)
  // res.send("heello")
})
router.get('/user/me', isLoggedIn, async function (req, res, next) {
  try {
    console.log(req.user)
    res.json(req.user)

  } catch (err) {
    next(err)
  }

});

exports.router = router;
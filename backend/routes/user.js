const express = require("express");
const pool = require("../config/db.config");
const Joi = require('joi');
const argon2 = require('argon2');

router = express.Router();

const passwordValidator = (value, helpers) => {
  if (value.length < 8) {
    throw new Joi.ValidationError('Password must contain at least 8 characters')
  }
  if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
    throw new Joi.ValidationError('Password must be harder')
  }
  return value
}

const usernameValidator = async (value, helpers) => {
  const [customer, _] = await pool.query("select c_username from Customer where c_username = ?", [value])
  const [admin] = await pool.query(`select a_username from Admin where a_username = ?`, [value])
  if (customer.length > 0 || admin.length > 0) {
    const message = 'This username is already taken'
    throw new Joi.ValidationError(message, { message })
  }
  return value
}

const signupSchema = Joi.object({
  email: Joi.string().required().email(),
  phonenumber: Joi.string().required().pattern(/0[0-9]{9}/),
  fname: Joi.string().required().max(150),
  lname: Joi.string().required().max(150),
  address:  Joi.string().required(),
  password: Joi.string().required().custom(passwordValidator),
  confirm_password: Joi.string().required().valid(Joi.ref('password')),
  username: Joi.string().required().min(5).max(20).external(usernameValidator),
})

router.post("/register", async function (req, res, next) {
  try {
    console.log(req.body)
    await signupSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    console.log(err.message)
    return res.status(400).send(err)
  }
  const username = req.body.username
  const password = await argon2.hash(req.body.password)
  const first_name = req.body.fname
  const last_name = req.body.lname
  const address = req.body.address
  const email = req.body.email
  const mobile = req.body.phonenumber
  try {
    await pool.query('INSERT INTO `Customer`(`c_username`, `c_password`, `c_first_name`, `c_last_name`, `c_address`, `c_email`, `c_phone`, `c_image`) \
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [username, password, first_name, last_name, address, email, mobile, ""]);
    res.send("add success")
  } catch (err) {
    res.status(400).json(err.toString());
  }
});


router.post("/signin", async function (req, res, next) {
  try {
    let admin = await pool.query("SELECT * FROM `Admin` where (a_username = ? or a_email = ?) and a_password = ?",
      [req.body.username, req.body.email, req.body.password]);
    let customer = await pool.query("SELECT * FROM `Customer` where (c_username = ? or c_email = ?) and c_password = ?",
      [req.body.username, req.body.email, req.body.password]);



    if (customer[0].length != 0) {
      customer[0][0].type = "customer"
      console.log(customer[0][0])
      res.json(customer[0][0])
    }
    else if (admin[0].length != 0) {
      admin[0][0].type = "admin"
      res.json(admin[0][0])
    }
    else {
      res.status(500).send("Invalid username or password !!!!");
    }
  } catch (err) {
    next(err)
  }
});

router.get('/imageProfile/', async function (req, res, next) {
  try {
    if (req.query.user == 'customer') {
      let result = await pool.query('select customer_id "id", c_username "username",c_image "image" from customer where customer_id = ?', [req.query.id])
      if (result[0].length != 0) {
        res.json(result[0][0])
      }
    }
    if (req.query.user == 'admin') {
      let result = await pool.query('select admin_id "id", a_username "username",a_image "image" from admin where admin_id = ?', [req.query.id])
      if (result[0].length != 0) {
        res.json(result[0][0])
      }
    }


  } catch (err) {
    next(err)
  }

});

exports.router = router;
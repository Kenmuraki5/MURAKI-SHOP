const express = require("express");
const pool = require("../config/db.config");
const Joi = require('joi');
const argon2 = require('argon2');
const jwt = require('jsonwebtoken');
const { isLoggedIn } = require('../middlewares/index')
const nodemailer = require('nodemailer');
router = express.Router();

const generatetoken = async (type, id) => {
  try {
    const secretKey = "MRa@uakinuthatke.murai2024laer@gadf////";
    const capitalizedType = type.charAt(0).toUpperCase() + type.slice(1);
    const [result] = await pool.query(`SELECT ${type}_id FROM ${capitalizedType} WHERE ${type}_id = ?`, [id]);
    const token = jwt.sign(result[0], secretKey, { algorithm: 'HS256' });
    console.log(token);
    return token;
  } catch (error) {
    throw new Error(error)
  }
}

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
  username: Joi.string().required().min(8).max(20).external(usernameValidator),
  password: Joi.string().required().custom(passwordValidator),
  confirm_password: Joi.string().required().valid(Joi.ref('password')),
  email: Joi.string().email().required().external(emailValidator),
  phonenumber: Joi.string().required().pattern(/0[0-9]{9}/),
  fname: Joi.string().required().max(150),
  lname: Joi.string().required().max(150),
  address: Joi.string().required(),
})

router.post("/register", async function (req, res, next) {
  console.log(req.body)
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
    const [check_customers] = await conn.query(
      'SELECT * FROM Customer WHERE (c_username = ? or c_email = ?)',
      [username, username]
    )
    const [check_admins] = await conn.query(
      'SELECT * FROM Admin WHERE (a_username = ? or a_email = ?)',
      [username, username]
    )
    const ck_customer = check_customers[0] == undefined ? "" : check_customers[0]
    const ck_admin = check_admins[0] == undefined ? "" : check_admins[0]
    // Check if username is correct
    if (!ck_customer && !ck_admin) {
      throw new Error('Incorrect username or email')
    }
    // Check if password is correct
    if (ck_customer && await argon2.verify(ck_customer.c_password, password)) {
      const [tokens] = await conn.query(
        'SELECT * FROM tokens_c WHERE user_id=?',
        [ck_customer.customer_id]
      )
      // Check if token already existed
      let token = tokens[0]?.token
      if (!token) {
        // Generate and save token into database
        token = await generatetoken("customer", ck_customer.customer_id)
        await conn.query('INSERT INTO tokens_c(user_id, token) VALUES (?, ?)', [ck_customer.customer_id, token])
      }
      conn.commit()
      res.status(200).json({ 'token': token })
    }
    else if (ck_admin && await argon2.verify(ck_admin.a_password, password)) {
      const [tokens] = await conn.query(
        'SELECT * FROM tokens_a WHERE user_id=?',
        [ck_admin.admin_id]
      )
      // Check if token already existed
      let token = tokens[0]?.token
      if (!token) {
        // Generate and save token into database
        token = await generatetoken("admin", ck_admin.admin_id)
        await conn.query('INSERT INTO tokens_a(user_id, token) VALUES (?, ?)', [ck_admin.admin_id, token])
      }
      conn.commit()
      res.status(200).json({ 'token': token })
    }
    else {
      throw new Error('Incorrect password')
    }

  } catch (error) {
    conn.rollback()
    next(error)
    res.status(400).json(error.toString())
  } finally {
    conn.release()
  }
});

const emailSchema = Joi.object({
  email: Joi.string().email().required(),
})


router.post("/verification", async function (req, res, next) {
  try {
    //ตรวจสอบความถูกต้องของข้อมูลด้วยคำสั่ง validate()
    await emailSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    return res.status(400).json(err.toString())
  }

  try {
    const [check_customer] = await pool.query("select customer_id from Customer where c_email = ?", [req.body.email])
    const [check_admin] = await pool.query("select admin_id from Admin where a_email = ?", [req.body.email])
    if (!check_customer[0] && !check_admin[0]) {
      res.status(409).send("This email does not exist in the system.")
    }
    else if(check_customer[0]){
      const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: 'murakishopp@gmail.com',
          pass: 'vuxjtsqgsipzdobh'
        }
      });
      check_customer[0].type = "customer"
      const token = jwt.sign(check_customer[0], "hangessapwodr", {expiresIn: 180000});
      var mailOptions = {
        from: 'murakishopp@gmail.com',
        to: req.body.email,
        subject: 'Password Reset',
        text: "http://34.125.149.37/ResetPassword/" + token
      };
      transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
          console.log(error);
          res.status(400).send("error")
        } else {
          console.log('Email sent: ' + info.response);
          res.send("success")
        }
      });
    }
    else if(check_admin[0]){
      const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: 'murakishopp@gmail.com',
          pass: 'vuxjtsqgsipzdobh'
        }
      });
      check_admin[0].type = "admin"
      const token = jwt.sign(check_admin[0], "@hangessapwodradf/>>.afdfa@12murakicomic", {expiresIn: 180000});
      var mailOptions = {
        from: 'murakishopp@gmail.com',
        to: req.body.email,
        subject: 'Password Reset',
        text: "http://34.125.149.37/ResetPassword/" + token
      };
      transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
          console.log(error);
          res.status(400).send("error")
        } else {
          console.log('Email sent: ' + info.response);
          res.send("success")
        }
      });
    }
  } catch (error) {
    next(error)
  }
})


const ResetPasswordSchema = Joi.object({
  password: Joi.string().required().custom(passwordValidator),
  confirm_password: Joi.string().required().valid(Joi.ref('password')),
})

router.put("/ResetPassword/:token/", async function (req, res, next) {
  try {
    //ตรวจสอบความถูกต้องของข้อมูลด้วยคำสั่ง validate()
    await ResetPasswordSchema.validateAsync(req.body, { abortEarly: false })
  } catch (err) {
    return res.status(400).json(err.toString())
  }
  jwt.verify(req.params.token, "@hangessapwodradf/>>.afdfa@12murakicomic", async function (err, decoded) {
    if (err) {
      console.log('JWT verification failed:', err.message);
      res.status(400).send("you cannot change password : "+ err.message)
    }
    else {
      console.log('JWT verification succeeded:', decoded.email);
      const conn = await pool.getConnection()
      await conn.beginTransaction()
      try {
        const password = await argon2.hash(req.body.password)
        if (decoded.type == "customer") {
          await conn.query("update customer set c_password = ? where customer_id = ?", [password, decoded.customer_id])
          await conn.query("DELETE FROM tokens_c WHERE user_id = ?", [customer[0].customer_id])
        }
        else if (decoded.type == "admin") {
          await conn.query("update admin set a_password = ? where admin_id = ?", [password, decoded.admin_id])
          await conn.query("DELETE FROM tokens_a WHERE user_id = ?", [admin[0].admin_id])
        }
        conn.commit()
        res.send("success")
      } catch (error) {
        conn.rollback()
        next(error)
      } finally {
        conn.release()
      }
    }
  });
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
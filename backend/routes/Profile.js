const express = require("express");
const pool = require("../config/db.config");

router = express.Router();
// Require multer for file upload
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

router.get("/profile", async function (req, res, next) {
  try {
    console.log(req.query.user)
    if(req.query.user == 'customer'){
      let result = await pool.query(`SELECT customer_id 'id', c_username 'username', c_password 'password', c_first_name 'first_name', c_last_name 'last_name',
     c_address 'address', c_email 'email', c_phone 'phone', c_image 'image' FROM Customer where customer_id = ${req.query.id}`);
     res.send(result[0][0])

    }
    if(req.query.user == 'admin'){
      let result = await pool.query(`SELECT admin_id 'id', a_username 'username', a_password 'password', a_first_name 'first_name', a_last_name 'last_name',
     a_address 'address', a_email 'email', a_phone 'phone', a_image 'image' FROM Admin where admin_id = ${req.query.id}`);
     res.send(result[0][0])
    }
    
  } catch (err) {
    return next(err)
  }
});


router.put("/EditProfile", async function (req, res, next) {
  try {
    if(req.body.user == 'customer'){
      await pool.query(`UPDATE CUSTOMER SET c_username = ?, c_password = ?, c_first_name = ?, c_last_name = ?,\
    c_address = ?, c_email = ?, c_phone = ? where customer_id = ?`, [req.body.username, req.body.password, req.body.fname, 
    req.body.lname, req.body.address, req.body.email, req.body.phonenumber, req.body.id]);
    }
    if(req.body.user == 'admin'){
      await pool.query(`UPDATE admin SET a_username = ?, a_password = ?, a_first_name = ?, a_last_name = ?,\
    a_address = ?, a_email = ?, a_phone = ? where admin_id = ?`, [req.body.username, req.body.password, req.body.fname, 
    req.body.lname, req.body.address, req.body.email, req.body.phonenumber, req.body.id]);
    }
    console.log("update success")
    res.send("success")
  } catch (err) {
    return next(err)
  }
});

router.put("/changepicture", upload.single('img'),async function (req, res, next) {
  try {
    const file = req.file;
    if(req.body.user == 'customer'){
      await pool.query(`UPDATE CUSTOMER SET c_image = ? where customer_id = ?`, [file.filename, req.body.id])
      let result = await pool.query(`select c_image 'image' from customer`)
      res.json(result[0][0])
    }
    if(req.body.user == 'admin'){
      await pool.query(`UPDATE admin SET a_image = ? where admin_id = ?`, [file.filename, req.body.id])
      let result = await pool.query(`select a_image 'image' from admin`)
      res.json(result[0][0])
    }
    console.log("success")
    
  } catch (err) {
    return next(err)
  }
});
exports.router = router;
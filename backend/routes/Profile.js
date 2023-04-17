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
    let result = await pool.query(`SELECT * FROM Customer where customer_id = ${req.query.id}`);
    res.send(result[0][0])
    console.log(result[0][0])
  } catch (err) {
    return next(err)
  }
});


router.put("/EditProfile", async function (req, res, next) {
  try {
    await pool.query(`UPDATE CUSTOMER SET c_username = ?, c_password = ?, c_first_name = ?, c_last_name = ?,\
    c_address = ?, c_email = ?, c_phone = ? where customer_id = ?`, [req.body.username, req.body.password, req.body.fname, 
    req.body.lname, req.body.address, req.body.email, req.body.phonenumber, req.body.id]);
    console.log("update success")
    res.send("success")
  } catch (err) {
    return next(err)
  }
});

router.put("/changepicture", upload.single('img'),async function (req, res, next) {
  try {
    const file = req.file;
    await pool.query(`UPDATE CUSTOMER SET c_image = ? where customer_id = ?`, [file.filename, req.body.id])
    let result = await pool.query(`select c_image from customer`)
    console.log("success")
    res.json(result[0][0])
  } catch (err) {
    return next(err)
  }
});
exports.router = router;
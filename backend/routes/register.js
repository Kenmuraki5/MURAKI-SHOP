const express = require("express");
const pool = require("../config/db.config");

router = express.Router();

router.post("/register", async function (req, res, next) {
  try {
    let result2 = await pool.query(`select c_username from Customer where c_username = ?`, [req.body.username])
    let result3 = await pool.query(`select a_username from Admin where a_username = ?`, [req.body.username])
    if(result2[0].length > 1  || result3[0].length > 1){
      res.status(500).send("This username has already been used !!!!");
    }
    else{
      await pool.query('INSERT INTO `Customer`(`c_username`, `c_password`, `c_first_name`, `c_last_name`, `c_address`, `c_email`, `c_phone`, `c_image`) \
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)', 
      [req.body.username, req.body.password, req.body.fname, req.body.lname, req.body.address, req.body.email, req.body.phonenumber, ""]);
      res.send("add success")
    }
    } catch (err) {
        next(err)
    }
});

exports.router = router;
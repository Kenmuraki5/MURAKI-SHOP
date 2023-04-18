const express = require("express");
const pool = require("../config/db.config");


router = express.Router();

router.get("/", async function (req, res, next) {
  try {
    let result = await pool.query("SELECT * FROM Book");
    res.send(result[0])
    console.log(result[0])
  } catch (err) {
    return next(err)
  }
});

router.post("/signin", async function (req, res, next) {
  try {
    let result = await pool.query("SELECT * FROM `Admin` where (a_username = ? or a_email = ?) and a_password = ?",
    [req.body.username, req.body.email, req.body.password]);
    let result2 = await pool.query("SELECT * FROM `Customer` where (c_username = ? or c_email = ?) and c_password = ?",
    [req.body.username, req.body.email, req.body.password]);
    if(result2[0].length != 0){
      result2[0][0].type = "customer"
      console.log(result2[0][0])
      res.json(result2[0][0])
    }
    else if(result[0].length != 0){
      result[0][0].type = "admin"
      res.json(result[0][0])
    }
    else{
      res.status(500).send("Invalid username or password !!!!");
    }
  } catch (err) {
    next(err)
  }
});

router.get('/imageProfile/', async function (req, res, next) {
  try {
    if(req.query.user == 'customer'){
      let result = await pool.query('select customer_id "id", c_username "username",c_image "image" from customer where customer_id = ?',[req.query.id])
      if(result[0].length != 0){
        res.json(result[0][0])
      }
    }
    if(req.query.user == 'admin'){
      let result = await pool.query('select admin_id "id", a_username "username",a_image "image" from admin where admin_id = ?',[req.query.id])
      if(result[0].length != 0){
        res.json(result[0][0])
      }
    }

    
  } catch (err) {
    next(err)
  }

});

exports.router = router;
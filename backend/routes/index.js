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
    let result = await pool.query("SELECT * FROM `Admin` where (a_username = ? or a_email = ?) and a_password = ? \
    UNION ALL SELECT * FROM `Customer` where (c_username = ? or c_email = ?) and c_password = ?", 
    [req.body.username, req.body.username, req.body.password, req.body.username, req.body.username, req.body.password]);
    if(result[0].length != 0){
      res.redirect("/")
    }
    else{
      res.status(500).send("Invalid username or password !!!!");
    }
  } catch (err) {
    next(err)
  }
});
exports.router = router;
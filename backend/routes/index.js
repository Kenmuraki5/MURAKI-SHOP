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
    let result = await pool.query("SELECT * FROM Customer where c_username = ? and c_password = ?", [req.body.username, req.body.password]);
    let result2 = await pool.query("SELECT * FROM Admin where a_username = ? and a_password = ?", [req.body.username, req.body.password]);
    if(result[0].length != 0){
      res.redirect("/")
    }
    if(result2[0].length != 0){
      res.redirect("/")
    }
    else{
      throw new Error("eee")
    }
  } catch (err) {
    next(err)
  }
});
exports.router = router;
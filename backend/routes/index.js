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

exports.router = router;
const express = require("express");
const pool = require("../config/db.config");

router = express.Router();

router.get("/DetailPage/:id", async function (req, res, next) {
  try {
    console.log(req.params.id)
    let result = await pool.query(`SELECT * FROM Book where isbn = ?` ,[req.params.id]);
    res.send(result[0][0])
    console.log(result[0])
  } catch (err) {
    return next(err)
  }
});

exports.router = router;
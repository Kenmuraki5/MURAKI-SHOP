const express = require("express");
const pool = require("../config/db.config");

router = express.Router();

router.get("/Manga", async function (req, res, next) {
  try {
    let result = await pool.query("SELECT a.*, group_concat(genre) as 'genres' FROM Book a join book_genres using (isbn) join genres b using(genre_id) where book_category = 'manga' group by isbn");
    res.send(result[0])
    console.log(result[0])
  } catch (err) {
    return next(err)
  }
});

exports.router = router;
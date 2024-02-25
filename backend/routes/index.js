const express = require("express");
const pool = require("../config/db.config");


router = express.Router();

router.get("/", async function (req, res, next) {
  try {
    let thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    let result = await pool.query("select * from Book where Publisher_date > ?", [thirtyDaysAgo]);
    res.send(result[0])
    // console.log(result[0])
  } catch (err) {
    return next(err)
  }
});

router.get("/recommended", async function (req, res, next) {
  try {
    let thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    await pool.query("SET sql_mode = '';");
    let [query] = await pool.query("SELECT o.isbn, o.book_name, COUNT(o.isbn), o.book_img, b.book_price, b.in_stock \
    FROM Order_Line o JOIN `Book` b ON (o.isbn = b.isbn) where o.isbn not in (select isbn from Book where Publisher_date > ?) \
    GROUP BY o.isbn HAVING COUNT(o.isbn) >= 1", [thirtyDaysAgo]);
    console.log(query);
    res.send(query);
  } catch (error) {
    return next(error);
  }
});
exports.router = router;

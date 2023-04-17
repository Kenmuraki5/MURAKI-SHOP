const express = require("express");
const pool = require("../config/db.config");

router = express.Router();

router.get("/DetailPage/:id", async function (req, res, next) {
  try {
    console.log(req.params.id)
    const results = []
    let bookDetail = await pool.query(`SELECT * FROM Book where isbn = ?` ,[req.params.id]);
    let bookComment = await pool.query(`SELECT comment_id, c_username, comment, created_at, c_image  FROM comments join customer using(customer_id) where isbn = ? order by created_at;`,
    [bookDetail[0][0].isbn])
    results.push(bookDetail[0][0])
    results.push(bookComment[0])
    res.send(results)
    
  } catch (err) {
    return next(err)
  }
});

router.post("/addComment/:id", async function (req, res, next) {
  try {

    let addComment = await pool.query('insert into comments (isbn, customer_id, comment) value (?,?,?)',
    [req.params.id, req.body.id, req.body.comment])
    res.redirect(`/DetailPage/${req.params.id}`)
    
  } catch (err) {
    return next(err)
  }
});
exports.router = router;
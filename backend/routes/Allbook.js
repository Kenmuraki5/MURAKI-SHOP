const express = require("express");
const path = require("path")
const pool = require("../config/db.config");
router = express.Router();


router.get("/AllBook/", async function (req, res, next) {
    try {
        let result = await pool.query(`SELECT a.*, group_concat(genre) as 'genres' FROM Book a join book_genres using (isbn) join genres b using(genre_id) group by isbn`)
        
        console.log(result[0])
        res.json(result[0])
    } catch (error) {
        next(error)
    }
});

router.post("/AllBook/:sortby", async function (req, res, next) {
//    try {
//         let result = req.params.sortby == "0" ? await pool.query(`SELECT * FROM BOOK ORDER BY publisher_date desc`) :
//         await pool.query(`SELECT * FROM BOOK ORDER BY book_price ${req.params.sortby}`)
//         res.json(result[0])
//    } catch (error) {
//         next(error)
//    }
});

router.get("/blogs/create", async function (req, res, next) {

});

// POST - create new blog with single upload file
router.post('/blogs', async function (req, res, next) {
    
});

// show detail
router.get("/blogs/:id", async function (req, res, next) {
  
});

//update blogs
router.put('/blogs/:id', async (req, res, next) => {

});

router.delete('/blogs/:id', async (req, res, next) => {

  
});

exports.router = router;
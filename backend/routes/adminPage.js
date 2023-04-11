const express = require("express");
const path = require("path")
const pool = require("../config/db.config");
router = express.Router();

// Require multer for file upload
const multer = require('multer')
// SET STORAGE
var storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, './static/uploads')
  },
  filename: function (req, file, callback) {
    callback(null, file.originalname)
  }
})
const upload = multer({ storage: storage })

router.get("/formBook", async function (req, res, next) {
    try {
        let result = []
        let publisher = await pool.query(`SELECT * from publisher`)
        result.push(publisher[0])
        let author = await pool.query(`SELECT * from author`);
        result.push(author[0])
        let genres = await pool.query(`SELECT * from genres`);
        result.push(genres[0])
        res.json(result)
    } catch (error) {
        next(error)
    }
});

router.post('/addBook', upload.single('image'), async function (req, res, next) {
    const form = req.body 
    const image = req.file.filename
    const conn = await pool.getConnection()
    await conn.beginTransaction();
    try{
        if(form.newPublisher == 1){
            let insertPublisher = await conn.query('INSERT INTO `Publisher` (`publisher_name`) VALUES (?)',
            [form.publisher])
            form.publisher = insertPublisher[0].insertId
        }
        if(form.newAuthor == 1){
            let insertAuthor = await conn.query('INSERT INTO `author` (`author_name`) VALUES (?)',
            [form.author])
            form.author = insertAuthor[0].insertId
        }
        let insertBook = await conn.query('INSERT INTO `Book` (`isbn`, `book_name`, `book_description`, `book_price`, `book_category`, `publisher_id`, `publisher_date`, `book_img`, `in_stock`) value(?,?,?,?,?,?,?,?,?)',
            [form.isbn,form.title,form.description,form.price,form.category,form.publisher,form.publisherDate,image,form.inStock])
        form.genres.split(",").forEach(async x => {
            let insertGenre = await conn.query('INSERT INTO `book_genres` (`isbn`, `genre_id`) VALUES (?, ?)',
            [form.isbn, x])
        });
        await conn.commit()
        res.json("success!")
    }
    catch(err){
        await conn.rollback();
        next(err)
    }
    finally {
        console.log('finally')
        conn.release();
      }
});

router.get("/blogs/create", async function (req, res, next) {

});

// POST - create new blog with single upload file

// show detail
router.get("/blogs/:id", async function (req, res, next) {
  
});

//update blogs
router.put('/blogs/:id', async (req, res, next) => {

});

router.delete('/blogs/:id', async (req, res, next) => {

  
});

exports.router = router;
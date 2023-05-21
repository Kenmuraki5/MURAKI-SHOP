const express = require("express");
const path = require("path")
const pool = require("../config/db.config");
const Joi = require('joi');
const { isLoggedIn } = require('../middlewares/index')

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

router.post('/addBook', isLoggedIn, upload.single('image'), async function (req, res, next) {
    if (req.user.type == "admin") {
        const { error } = bookSchema.validate(req.body);
        if (error) {
            const errors = error.details.map((detail) => detail.message);
            return res.status(500).json(errors);
        } else {
            console.log('Validation passed successfully.');
        }
        if (!req.file) {
            return res.status(500).json(
                "Please upload file."
            )
        }
        const form = req.body
        const image = req.file.filename
        const conn = await pool.getConnection()
        await conn.beginTransaction();
        try {
            let selectBook = await conn.query('select * from book where isbn = ?', [form.isbn])
            if (selectBook[0].length == 1) {
                return res.status(409).json("Has Same Book ISBN " + form.isbn)
            }
            if (isNaN(parseFloat(form.publisher))) {
                let selectPublisher = await conn.query('select * from Publisher where publisher_name = ?', [form.publisher])
                if (selectPublisher[0].length >= 1) {
                    form.publisher = selectPublisher[0][0].publisher_id
                } else {
                    let insertPublisher = await conn.query('INSERT INTO `Publisher` (`publisher_name`) VALUES (?)',
                        [form.publisher])
                    form.publisher = insertPublisher[0].insertId
                }
            }
            if (isNaN(parseFloat(form.author))) {
                let selectAuthor = await conn.query('select * from author where author_name = ?', [form.author])
                if (selectAuthor[0].length >= 1) {
                    form.author = selectAuthor[0][0].author_id
                } else {
                    let insertAuthor = await conn.query('INSERT INTO `author` (`author_name`, `author_alias`) VALUES (?, ?)',
                        [form.author, form.newAuthorAlias])
                    form.author = insertAuthor[0].insertId
                }
            }
            let selectAuthor = await conn.query('select * from author where author_id = ?', [form.author])
            if (selectAuthor[0].length == 0) {
                return res.status(409).json("Can't Find Author ID " + form.author)
            }
            let selectPublisher = await conn.query('select * from Publisher where Publisher_id = ?', [form.publisher])
            if (selectPublisher[0].length == 0) {
                return res.status(409).json("Can't Find Publisher ID " + form.publisher)
            }
            let insertBook = await conn.query('INSERT INTO `Book` (`isbn`, `book_name`, `book_description`, `book_price`, `book_category`, `publisher_id`, `publisher_date`, `book_img`, `in_stock`) value(?,?,?,?,?,?,?,?,?)',
                [form.isbn, form.title, form.description, form.price, form.category, form.publisher, form.publisherDate, image, form.inStock])
            let genreNotFound = false;
            let NotFoundGenre = null;
            for (const genreId of form.genres.split(",")) {
                let selectGenre = await conn.query('SELECT * FROM genres WHERE genre_id = ?', genreId);
                if (selectGenre[0].length === 0) {
                    genreNotFound = true;
                    NotFoundGenre = genreId
                    break;
                }
            }
            if (genreNotFound) {
                return res.status(409).json("Can't Find Genre ID " + NotFoundGenre);
            } else {
                form.genres.split(",").forEach(async x => {
                    let insertGenre = await conn.query('INSERT INTO `book_genres` (`isbn`, `genre_id`) VALUES (?, ?)',
                        [form.isbn, x])
                });
            }
            let insertBookAuthor = await conn.query('INSERT INTO `Book_Author` (isbn,author_id) value(?,?)',
                [form.isbn, form.author])
            await conn.commit()
            return res.json("Add Book Success!")
        }
        catch (err) {
            await conn.rollback();
            return res.status(409).json(err)
        }
        finally {
            console.log('finally')
            conn.release();
        }
    }
    else {
        return res.status(409).json("You are not Admin")
    }
});

router.put("/editBook", isLoggedIn, upload.single('image'), async function (req, res, next) {
    if (req.user.type == "admin") {
        const { error } = bookSchema.validate(req.body);
        if (error) {
            const errors = error.details.map((detail) => detail.message);
            return res.status(500).json(errors);
        } else {
            console.log('Validation passed successfully.');
        }
        if (!req.file && !req.body.sameImage) {
            return res.status(500).json(
                "Please upload file."
            )
        }
        const form = req.body;
        const image = req.file ? req.file.filename: req.body.sameImage
        console.log(image)
        const conn = await pool.getConnection()
        await conn.beginTransaction();
        try {
            let selectBook = await conn.query('select * from book where isbn = ?', [form.oldIsbn])
            if (selectBook[0].length == 0) {
                return res.status(409).json("Can't Find Book ISBN " + form.oldIsbn)
            }
            if (image != "sameasbefore.png") {
                await conn.query('update book set book_img = ? where isbn = ?',
                    [image, form.oldIsbn])
            }
            if (isNaN(parseFloat(form.publisher))) {
                let selectPublisher = await conn.query('select * from Publisher where publisher_name = ?', [form.publisher])
                if (selectPublisher[0].length >= 1) {
                    form.publisher = selectPublisher[0][0].publisher_id
                } else {
                    let insertPublisher = await conn.query('INSERT INTO `Publisher` (`publisher_name`) VALUES (?)',
                        [form.publisher])
                    form.publisher = insertPublisher[0].insertId
                }
            }
            if (isNaN(parseFloat(form.author))) {
                let selectAuthor = await conn.query('select * from author where author_name = ?', [form.author])
                if (selectAuthor[0].length >= 1) {
                    form.author = selectAuthor[0][0].author_id
                } else {
                    let insertAuthor = await conn.query('INSERT INTO `author` (`author_name`, `author_alias`) VALUES (?, ?)',
                        [form.author, form.newAuthorAlias])
                    form.author = insertAuthor[0].insertId
                }
            }
            let selectAuthor = await conn.query('select * from author where author_id = ?', [form.author])
            if (selectAuthor[0].length == 0) {
                return res.status(409).json("Can't Find Author ID " + form.author)
            }
            let selectPublisher = await conn.query('select * from Publisher where Publisher_id = ?', [form.publisher])
            if (selectPublisher[0].length == 0) {
                throw res.status(409).json("Can't Find Publisher ID " + form.publisher)
            }
            await conn.query('delete from book_genres where isbn = ?', [form.oldIsbn])
            await conn.query('update book set isbn = ?, book_name = ?, book_description = ?, book_price = ?, book_category = ?, publisher_id = ?, publisher_date = ?, in_stock = ? where isbn = ?',
                [form.isbn, form.title, form.description, form.price, form.category, form.publisher, form.publisherDate, form.inStock, form.oldIsbn])
            let genreNotFound = false;
            let NotFoundGenre = null;
            for (const genreId of form.genres.split(",")) {
                let selectGenre = await conn.query('SELECT * FROM genres WHERE genre_id = ?', genreId);
                if (selectGenre[0].length === 0) {
                    genreNotFound = true;
                    NotFoundGenre = genreId
                    break;
                }
            }
            if (genreNotFound) {
                return res.status(409).json("Can't Find Genre ID " + NotFoundGenre);
            } else {
                form.genres.split(",").forEach(async x => {
                    let insertGenre = await conn.query('INSERT INTO `book_genres` (`isbn`, `genre_id`) VALUES (?, ?)',
                        [form.isbn, x])
                });
            }
            let insertBookAuthor = await conn.query('update `Book_Author` set author_id = ? where isbn = ?',
                [form.author, form.isbn])
            await conn.commit()
            return res.json("Edit Book Success!")
        } catch (err) {
            await conn.rollback();
            return res.status(409).json(err)
        }
        finally {
            console.log('finally')
            conn.release();
        }
    } else {
        return res.status(409).json("You are not Admin")
    }
});
router.get("/editBook", async function (req, res, next) {
    try {
        let result = await pool.query(`SELECT a.*, c.*, d.*, g.genres, g.genres_id
        FROM Book a
        JOIN publisher c USING(publisher_id)
        JOIN book_author USING(isbn)
        JOIN author d USING(author_id)
        JOIN (
          SELECT isbn, GROUP_CONCAT(genre) AS genres, GROUP_CONCAT(genre_id) AS genres_id
          FROM book_genres
          JOIN genres USING(genre_id)
          GROUP BY isbn
        ) g ON a.isbn = g.isbn`)
        res.json(result[0])
    } catch (error) {
        next(error)
    }
});
router.delete('/editBook/', isLoggedIn, async (req, res, next) => {
    if (req.user.type == "admin") {
        const conn = await pool.getConnection()
        await conn.beginTransaction();
        try {
            await conn.query('DELETE FROM book WHERE isbn = ?', [req.query.isbn])
            await conn.commit()
            res.json("success!")
        } catch (err) {
            await conn.rollback();
            next(err)
        }
        finally {
            console.log('finally')
            conn.release();
        }
    } else {
        return res.status(409).json("You are not Admin")
    }
});

router.get('/allSlip/', async (req, res, next) => {

    try {
        // select * from payment join cust_order using(order_id) join order_line using(order_id)
        const payment = await pool.query("SELECT c_username, order_id, GROUP_CONCAT(isbn) AS isbn, GROUP_CONCAT(book_name) AS name, \
        GROUP_CONCAT(quantity) AS quantity, GROUP_CONCAT(price) AS price, shipping_name, total_price AS total_price,\
        DATE_FORMAT(order_date,'%m/%d/%Y, %H:%i:%s') AS order_date, slip_img, status_value \
        FROM payment JOIN cust_order USING(order_id) \
        JOIN order_line USING(order_id) \
        JOIN customer USING(customer_id)JOIN book USING(isbn)\
		JOIN shipping_method USING(shipping_id) GROUP BY c_username, \
        order_id, slip_img, status_value, DATE_FORMAT(order_date,'%m/%d/%Y, %H:%i:%s')")
        res.json(payment[0])
    } catch (err) {
        next(err)
    }
    finally {
        console.log('finally')
    }
})

router.get('/getAllCustomer/', async (req, res, next) => {

    try {
        // select * from payment join cust_order using(order_id) join order_line using(order_id)
        const customers = await pool.query("")
        res.json(customers[0])
    } catch (err) {
        next(err)
    }
    finally {
        console.log('finally')
    }
})

router.put('/approve/', async (req, res, next) => {
    const conn = await pool.getConnection()
    await conn.beginTransaction();
    console.log(req.body)
    try {
        await conn.query('update payment set payment_status = "success" WHERE order_id = ?', [req.body.order_id])
        await conn.query('update cust_order set status_value = "shipping" WHERE order_id = ?', [req.body.order_id])
        res.json('done')
        await conn.commit()
    } catch (err) {
        await conn.rollback();
        next(err)
    }
    finally {
        console.log('finally')
        conn.release();
    }
})

router.put('/decline/', async (req, res, next) => {
    isbn = req.body.isbn.split(',')
    quantity = req.body.quantity.split(',')
    console.log(isbn)
    console.log(quantity)
    const conn = await pool.getConnection()
    await conn.beginTransaction();
    console.log(req.body)
    try {
        await conn.query('update payment set payment_status = "cancel" WHERE order_id = ?', [req.body.order_id])
        await conn.query('update cust_order set status_value = "cancel" WHERE order_id = ?', [req.body.order_id])
        isbn.forEach(async (x, index) => {
            await conn.query('update book set in_stock = in_stock+? WHERE isbn = ?', [quantity[index], x])

        })
        await conn.commit()
        res.json('done')

    } catch (err) {
        await conn.rollback();
        next(err)
    }
    finally {
        console.log('finally')
        conn.release();
    }
})


const bookSchema = Joi.object({
    oldIsbn: Joi.string().length(13).optional().messages({
        'string.base': 'Old ISBN must be a string.',
        'string.length': 'Old ISBN length must be 13 characters.',
    }),
    sameImage: Joi.string().optional().messages({
        'string.base': 'Image must be a string.',
    }),
    isbn: Joi.string().length(13).required().messages({
        'string.base': 'ISBN must be a string.',
        'string.length': 'ISBN length must be 13 characters.',
        'any.required': 'ISBN is required.',
    }),
    title: Joi.string().required().messages({
        'string.base': 'Title must be a string.',
        'any.required': 'Title is required.',
    }),
    price: Joi.number().min(0).required().messages({
        'number.base': 'Price must be a number.',
        'number.min': 'Price cannot be negative.',
        'any.required': 'Price is required.',
    }),
    description: Joi.string().required().messages({
        'string.base': 'Description must be a string.',
        'any.required': 'Description is required.',
    }),
    category: Joi.string()
        .valid('manga', 'novel')
        .required()
        .messages({
            'string.base': 'Category must be a string.',
            'any.required': 'Category is required.',
            'any.only': 'Category must be either "manga" or "novel".',
        }),
    publisher: Joi.alternatives().try(
        Joi.string().required(),
    ).messages({
        'any.required': 'Publisher is required.',
    }),
    publisherDate: Joi.string().required().messages({
        'string.base': 'Publisher date must be a string.',
        'any.required': 'Publisher date is required.',
    }),
    author: Joi.alternatives().try(
        Joi.string().required(),
    ).messages({
        'any.required': 'Author is required.',
    }),
    newAuthorAlias: Joi.string().when('author', {
        is: !Joi.number(),
        then: Joi.required().messages({
            'string.base': 'Author alias must be a string.',
            'any.required': 'Author alias is required.',
        }),
    }),
    genres: Joi.required().messages({
        'any.required': 'At least one genre must be selected.',
    }),
    inStock: Joi.number().min(0).required().messages({
        'number.base': 'Amount must be a number.',
        'number.min': 'Amount cannot be negative.',
        'any.required': 'Amount is required.',
    }),
});

exports.router = router;
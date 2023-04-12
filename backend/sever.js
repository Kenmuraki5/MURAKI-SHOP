const express = require("express");
// const bodyParser = require("body-parser"); /* deprecated */
const cors = require("cors");

const app = express();

// var corsOptions = {
//   origin: "http://localhost:8081"
// };
app.use(express.static('static'))

app.use(cors());

// parse requests of content-type - application/json
app.use(express.json()); /* bodyParser.json() is deprecated */

// parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true })); /* bodyParser.urlencoded() is deprecated */

// route
const indexRouter = require('./routes/index')
const AllbookRouter = require('./routes/Allbook')
const MangaRouter = require('./routes/Manga')
const NovelRouter = require('./routes/LightNovel')
const adminRouter = require('./routes/adminPage')
const CheckoutRouter = require('./routes/Checkout')
const DetailPage = require('./routes/DetailPage')
const Register = require('./routes/register')

app.use(indexRouter.router)
app.use(AllbookRouter.router)
app.use(MangaRouter.router)
app.use(NovelRouter.router)
app.use(adminRouter.router)
app.use(CheckoutRouter.router)
app.use(DetailPage.router)
app.use(Register.router)


// set port, listen for requests
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port http://localhost:${PORT}.`);
});
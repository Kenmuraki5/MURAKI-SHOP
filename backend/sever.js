const express = require("express");
// const bodyParser = require("body-parser"); /* deprecated */
const cors = require("cors");

const app = express();

// var corsOptions = {
//   origin: "http://localhost:8081"
// };
app.use("/images", express.static('static'))

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
const user = require('./routes/user')
const Profile = require('./routes/Profile')
const Orderdetail = require('./routes/Orderdetail')


app.use("/api", indexRouter.router)
app.use("/api", AllbookRouter.router)
app.use("/api", MangaRouter.router)
app.use("/api", NovelRouter.router)
app.use("/api", adminRouter.router)
app.use("/api", CheckoutRouter.router)
app.use("/api", DetailPage.router)
app.use("/api", user.router)
app.use("/api", Profile.router)
app.use("/api", Orderdetail.router)


// set port, listen for requests
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port http://localhost:${PORT}.`);
});
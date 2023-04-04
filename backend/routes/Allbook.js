const express = require("express");
const path = require("path")
const pool = require("../config/db.config");
router = express.Router();


router.get("/blogs/search", async function (req, res, next) {
  
});

router.post("/blogs/addlike/:blogId", async function (req, res, next) {
  
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
const express = require("express");
const pool = require("../config/db.config");
const Joi = require('joi');
const argon2 = require('argon2');
const jwt = require('jsonwebtoken');
const { isLoggedIn } = require('../middlewares/index')

router.get("/orderDetails", isLoggedIn, async function (req, res, next) {
    try {
      if(req.user.type == "customer"){
        const [order_customer] = await pool.query(`SELECT * FROM Cust_Order join Shipping_Method using(shipping_id) where customer_id = 3`)
        res.send(order_customer)
      }
      else{
        throw new Error('you are not customer')
      }
      
    } catch (error) {
      res.status(400).json(error.toString())
    }
});






exports.router = router;
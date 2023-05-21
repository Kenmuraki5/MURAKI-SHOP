const express = require("express");
const pool = require("../config/db.config");
const Joi = require('joi');
const argon2 = require('argon2');
const jwt = require('jsonwebtoken');
const { isLoggedIn } = require('../middlewares/index')

router.get("/orderDetails", isLoggedIn, async function (req, res, next) {
    try {
      if(req.user.type == "customer"){
        const [order_customer] = await pool.query(`SELECT *, DATE_FORMAT(order_date, "%Y-%m-%d")as order_date \
        FROM Cust_Order join Shipping_Method using(shipping_id) where customer_id = ${req.user.customer_id}`)
        if(req.query.status){
          const [order_customer] = await pool.query(`SELECT *, DATE_FORMAT(order_date, "%Y-%m-%d")as order_date \
          FROM Cust_Order join Shipping_Method using(shipping_id) where customer_id = ${req.user.customer_id} and \
          status_value = ?`, [req.query.status])
          return res.send(order_customer)
        }
        res.send(order_customer)
      }
      else{
        throw new Error('you are not customer')
      }
    } catch (error) {
      next(error)
      res.status(400).json(error.toString())
    }
});

router.post("/orderline", isLoggedIn, async function (req, res, next){
  try {
    const order_id = req.body.order_id
    const [orderline] = await pool.query("select * from Order_Line join book using(isbn) where order_id = ?",[order_id])
    res.send(orderline)
  } catch (error) {
    next(error)
    res.status(400).json(error.toString())
  }
})






exports.router = router;
const otpGenerator = require('otp-generator')
const nodemailer = require('nodemailer');
const argon2 = require('argon2');
const pool = require("../config/db.config");
async function sendotp(req, res, next) {
    var email
    const otp = otpGenerator.generate(6, { upperCaseAlphabets: false, specialChars: false });
    if(req.user.type == "customer"){
        email = req.user.c_email
        let otp2 = await argon2.hash(otp)
        await pool.query("update Customer set otp = ? where customer_id = ? ",[otp2, req.user.customer_id])
    }
    if(req.user.type == "admin"){
        email = req.user.a_admin
        let otp2 = await argon2.hash(otp)
        await pool.query("update Admin set otp = ? where admin_id = ? ",[otp2, req.user.admin_id])
    }
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: 'murakishopp@gmail.com',
          pass: 'vuxjtsqgsipzdobh'
        }
      });
      var mailOptions = {
        from: 'murakishopp@gmail.com',
        to: email,
        subject: 'Password Reset',
        html: `<html> <h1>Muraki shop change email</h1> <br/><p style="color:grey; font-size:1.2em">Please use the below OTP code to complete your Change Password</p><br><br><h1 style="color:orange">${otp}</h1></html>`
      };
      transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
          console.log(error);
          return res.status(400).send("error")
        } else {
          console.log('Email sent: ' + info.response);
          next()
        }
      });
}

module.exports = {
    sendotp
}
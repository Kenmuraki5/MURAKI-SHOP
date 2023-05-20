const otpGenerator = require('otp-generator')
const nodemailer = require('nodemailer');

function sendotp(req, res, next) {
    var email
    const otp = otpGenerator.generate(6, { upperCaseAlphabets: false, specialChars: false });
    if(req.user.type == "customer"){
        email = req.user.c_email
    }
    if(req.user.type == "admin"){
        email = req.user.a_admin
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
        text: otp
      };
      transporter.sendMail(mailOptions, function (error, info) {
        if (error) {
          console.log(error);
          return res.status(400).send("error")
        } else {
          console.log('Email sent: ' + info.response);
          req.otp = otp
          next()
        }
      });
}

module.exports = {
    sendotp
}
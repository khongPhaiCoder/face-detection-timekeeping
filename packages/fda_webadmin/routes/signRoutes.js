const express = require("express");
const User = require("../models/user");
// const User = require('../models/user');
// const getUser = require('../config/login.js');

const router = express.Router();

// Login route
router.post("/login", async (req, res) => {
  const { email, password } = req.body;
  console.log({ email, password }, req.body, "LOGIN");
  const login = await User.findOne({ email });
  if (login) {
    if (password === login.password) {
      console.log("roleeeee", login.role);
      if (login.role === "admin") {
        let id_user = login._id;
        console.log("id user", id_user);
        console.log(login, "aaaall");
        req.session.userId = login._id;
        res.redirect(`/dashboard`);
      } else {
        res.status(402).send("Your account cannot sign");
      }
    } else {
      res.status(401).send("Incorrect email or password");
    }
  } else {
    res.status(401).send("Incorrect email or password");
  }
});
// function getUser(req, res) {

//   let user_id = req.params.id;

//   User.findOne({'_id': user_id}, (err, user) => {

//       if(err) {
//           return res.json(err);
//       }

//       return res.json(user);

//   });

// }
// router.get('/', getUser());

// Register route
router.post("/register", async (req, res) => {
  const { name, email, password } = req.body;
  const role = "admin";
  console.log("rb: ", req.body);
  const existingLogin = await User.findOne({ email });
  if (existingLogin) {
    res.status(409).send("Username already exists");
    return;
  }
  const login = new User({ name, email, password, role });
  await login.save();
  // res.send('Account created successfully');
  res.redirect("/");
});

// Logout route
router.post("/logout", (req, res) => {
  req.session.destroy();
  res.redirect(`/`);
});

module.exports = router;

const express = require("express");
const User = require("../models/user");
// const helper = require("../publsic/helper");
const router = express.Router();

// Login route
router.post("/listUser", async (req, res) => {
  let listUser = await User.find();
  res.render("users/listUser", { listUser });
});

router.get("/add", async (req, res) => {
  res.render("users/addUser");
});

router.post("/addUser", async (req, res) => {
  let admin_id = req.session.userId;
  console.log("sssssssss", admin_id);
  let current_account = await User.find({ _id: admin_id });
  console.log("asfasfg", current_account);
  if (current_account[0].role === "admin") {
    let { name, email, salaryBase, password } = req.body;
    const existingLogin = await User.findOne({ email });
    if (existingLogin) {
      res.status(409).send("Username already exists");
      return;
    }
    // let password = "123";
    const role = "admin";
    console.log("rb: ", req.body);
    const login = new User({ name, email, password, role, salaryBase });
    await login.save();
    res.redirect("/listUser");
  } else {
    res.send("You cannot add user");
  }
});

router.get("/edit/:id", async (req, res) => {
  let id = req.params.id;
  // console.log("idd",id);
  let user = await User.find({ _id: id });
  console.log("fasgas", user);
  res.render("users/editUser", { user: user });
});

router.post("/edit/:id", async (req, res) => {
  let user_id = req.params.id;
  let admin_id = req.session.userId;
  // console.log(req.session.userId,"ppp");
  let current_account = await User.find({ _id: admin_id });
  if (current_account[0].role === "admin") {
    await User.find({ _id: user_id }).update([
      {
        $set: {
          name: req.body.name,
          email: req.body.email,
          salaryBase: req.body.salaryBase,
        },
      },
    ]);
  }

  res.redirect("/listUser");
});
router.get("/delete/:id", async (req, res) => {
  let user_id = req.params.id;
  let admin_id = req.session.userId;
  // console.log(req.session.userId,"ppp");
  let current_account = await User.find({ _id: admin_id });
  if (current_account[0].role === "admin") {
    await User.findByIdAndDelete(user_id);
  }
  res.redirect("/listUser");
});

module.exports = router;

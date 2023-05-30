const express = require("express");
const User = require("../models/user");
const Hitories = require("../models/hitories");
const userController = require("../controllers/monthAnalysis");

// const helper = require("../public/helper");
const router = express.Router();

router.get("/detail/:id", async (req, res) => {
  let id = req.params.id;
  console.log("id pp", id);
  let user = await User.find({ _id: id });
  let listHis = await Hitories.find({ user: id });
  console.log("hí", user);
  res.render("user/show", { listHis, user });
});

router.get("/monthly", userController.getUserMonthly);

router.get("/monthly/:month/:year", userController.getMonthly);

router.get("/month/:id", async (req, res) => {
  let id = req.params.id;
  // console.log("id pp", id);
  let now = new Date();
  let currentMonth = now.getMonth() + 1;
  let currentYear = now.getFullYear();
  monthYear = currentMonth + "/" + currentYear;
  console.log(monthYear, "myyyy");
  let user = await User.findById(id);
  console.log(user.salaryBase, "dasgaihjgi");
  let listH = await Hitories.find({ user: id });
  let monthlyHour = 0;
  let listHis = [];
  for (let i = 0; i < listH.length; i++) {
    month = listH[i].date.slice(3, 5);
    year = listH[i].date.slice(6, 12);
    if (month == currentMonth && year == currentYear) {
      // console.log(Number(listHis[i].time), "number");
      monthlyHour += Number(listH[i].time);
      listHis.push(listH[i]);
    }
  }
  res.render("user/monthly", { listHis, user, monthlyHour });
});

router.get("/date/:id", async (req, res) => {
  let id = req.params.id;
  console.log("id pp", id);
  let his = await Hitories.find({ _id: id });
  console.log("lmkg", his);
  let user = await User.find({ _id: his[0].user });
  console.log("hiss", user);
  res.render("user/detail_date", { his, user });
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
        },
      },
    ]);
  }

  res.redirect("/listUser");
});
router.post("/delete/:id", async (req, res) => {
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

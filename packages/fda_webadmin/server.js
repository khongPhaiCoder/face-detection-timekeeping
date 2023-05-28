const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
// const bcrypt = require('bcrypt')
// const initRoutes = require('./routes/loginRoutes.js')
const User = require("./models/user");
const Hitories = require("./models/hitories");
const methodOverride = require("method-override");
const app = express();
const path = require("path");
const port = 3337;
const session = require("express-session");
const loginRoutes = require("./routes/signRoutes");
const user = require("./routes/user");
const TimeAnalysis = require("./routes/timeAnalysis");
// const helper = require("./helper");
const { log } = require("console");
//cnn db
mongoose.connect(
  "mongodb+srv://khoa:khoa@cluster0.hyxxp.mongodb.net/face-detect",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
  }
);

// Set up session middleware
app.use(
  session({
    secret: "mysecretkey",
    resave: false,
    saveUninitialized: false,
  })
);

//conf static
app.use(express.static("public"));

// Set up body parsing middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Include login routes
app.use("/", loginRoutes);

app.use("/user", user);
app.use("/timeAnalysis", TimeAnalysis);
//view

app.set("view engine", "ejs");

app.get("/listUser", async (req, res) => {
  let listUser = await User.find({ role: "staff" });
  // let listUser = await User.find();

  let list = JSON.stringify(listUser);
  // console.log("list", listUser[1].role);
  res.render("users/listUser", { list: list });
});

app.post("/upload", (req, res) => {
  console.log("ok");
});

app.post("/", (req, res) => {
  console.log(req.body);
});

app.get("/", async (req, res) => {
  res.render("sign/login");
});

app.get("/register", async (req, res) => {
  res.render("sign/register");
});

app.get("/dashboard", async (req, res) => {
  let userId = req.session.userId;
  let users = await User.find({ role: "staff" });
  // let users = await User.find();

  for (let i = 0; i < users.length; i++) {
    let his = await Hitories.find({ user: users[i]._id }).select("time date");

    let total_time = 0;
    for (let j = 0; j < his.length; j++) {
      let monthHis = Number(his[j].date.slice(3, 5)) - 1;
      let now = new Date();
      let currentMonth = now.getMonth();
      if (his[j].time != undefined && monthHis == currentMonth) {
        console.log(his[j].date.slice(3, 5), "tam");
        total_time += parseInt(his[j].time);
        // console.log("tia", parseInt(his[j].time), total_time);
      }
    }
    console.log("ttt", total_time);
    users[i].his_list = his;
    users[i].time = total_time;
    // console.log("his", his, "ll", users[i]);
  }

  users.sort(function (a, b) {
    return b.time - a.time;
  });
  for (let index = 0; index < users.length; index++) {
    console.log(users[index].time, ">>>");
  }
  // console.log("id: ", users);
  res.render("user/index", { users });
});

app.listen(port, () => {
  console.log(`port ${port}`);
});

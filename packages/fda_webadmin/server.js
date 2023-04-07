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
const port = 3332;
const session = require("express-session");
const loginRoutes = require("./routes/signRoutes");
const user = require("./routes/user");
const TimeAnalysis = require("./routes/timeAnalysis");
const { log } = require("console");
//cnn db
mongoose.connect(
  "mongodb+srv://khoa:khoa@cluster0.hyxxp.mongodb.net/face-detect",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
  },
);

// Set up session middleware
app.use(
  session({
    secret: "mysecretkey",
    resave: false,
    saveUninitialized: false,
  }),
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
  const userId = req.session.userId;
  let users = await User.find({ role: "staff" });

  // console.log(his,"kkk");
  for (let i = 0; i < users.length; i++) {
    let his = await Hitories.find({ user: users[i]._id });
    let total_time = his.reduce((acc, obj) => {
      console.log(obj.time, "time");
      return acc + parseInt(obj.time);
    }, 0);
    console.log("ttt", total_time);
    users[i].his_list = his;
    users[i].time = total_time;
  }

  // console.log("id: ", users);
  res.render("user/index", { users });
});

app.listen(port, () => {
  console.log(`port ${port}`);
});

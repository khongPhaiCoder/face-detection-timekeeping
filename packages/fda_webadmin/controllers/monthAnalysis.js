const express = require("express");
const User = require("../models/user");
const Hitories = require("../models/hitories");

exports.getUserMonthly = async (req, res) => {
  let users = await User.find({ role: "staff" });
  historyList = [];
  let now = new Date();
  let currentMonth = now.getMonth() + 1;
  let currentYear = now.getFullYear();
  let option = currentMonth + "/" + currentYear;
  console.log("optionnnnn", option);
  for (let i = 0; i < users.length; i++) {
    let monthlyHour = 0;
    let listHis = [];
    let total_time = 0;
    let listH = await Hitories.find({ user: users[i]._id }).select("time date");
    for (let j = 0; j < listH.length; j++) {
      month = listH[j].date.slice(3, 5);
      year = listH[j].date.slice(6, 12);
      if (
        listH[j].time != undefined &&
        month == currentMonth &&
        year == currentYear
      ) {
        monthlyHour += Number(listH[j].time);
        listHis.push(listH[j]);
        total_time += parseInt(listH[j].time);
      }
    }

    // console.log("ttt", total_time);
    users[i].his_list = listH;
    users[i].time = total_time;
    users[i].password = (monthlyHour / 160) * Number(users[i].salaryBase);
    historyList.push(listHis);
    // console.log("his", his, "ll", users[i]);
  }

  users.sort(function (a, b) {
    return b.time - a.time;
  });
  for (let index = 0; index < users.length; index++) {
    // console.log(users[index].time, ">>>");
  }
  let months = [];
  let his = await Hitories.find().select("date user time");
  for (let i = 0; i < his.length; i++) {
    // console.log(his[i].date, "----");
    let month = Number(his[i].date.slice(3, 5));
    let year = his[i].date.slice(6, 12);
    let my = month + "/" + year;
    if (!months.includes(my)) {
      months.push(my);
    }
    // console.log(months, "month");
  }
  // console.log("users", users);
  res.render("listUser/monthly", { months, users, option });
};

exports.getMonthly = async (req, res) => {
  let users = await User.find({ role: "staff" });
  historyList = [];
  for (let i = 0; i < users.length; i++) {
    let currentMonth = Number(req.params.month);
    let currentYear = req.params.year;
    console.log("..........", req.params);

    let monthlyHour = 0;
    let listHis = [];
    let total_time = 0;
    let listH = await Hitories.find({ user: users[i]._id }).select("time date");
    for (let j = 0; j < listH.length; j++) {
      month = Number(listH[j].date.slice(3, 5));
      year = listH[j].date.slice(6, 12);
      console.log("???????", month == currentMonth, year == currentYear);
      if (
        listH[j].time != undefined &&
        month == currentMonth &&
        year == currentYear
      ) {
        monthlyHour += Number(listH[j].time);
        listHis.push(listH[j]);
        total_time += parseInt(listH[j].time);
      }
    }

    // console.log("ttt", total_time);
    users[i].his_list = listH;
    users[i].time = total_time;
    historyList.push(listHis);
    // console.log("his", his, "ll", users[i]);
  }

  for (let index = 0; index < users.length; index++) {
    console.log(users[index].time, ">>>");
  }
  let months = [];
  let his = await Hitories.find().select("date user time");
  for (let i = 0; i < his.length; i++) {
    // console.log(his[i].date, "----");
    let month = Number(his[i].date.slice(3, 5));
    let year = his[i].date.slice(6, 12);
    let my = month + "/" + year;
    if (!months.includes(my)) {
      months.push(my);
    }
    // console.log(months, "month");
  }
  let option = req.params.month + "/" + req.params.year;
  console.log("option", option);
  res.render("listUser/monthly", { months, users, option });
};

const express = require('express');
const User = require('../models/user');
const Hitories = require("../models/hitories");


const router = express.Router();

// Login route
router.get('/detail/:id', async (req, res) => {
  let id = req.params.id;
  console.log("id pp",id);
  let user = await User.find({_id: id});
  let listHis = await Hitories.find({user: id});
  console.log("hí",user);
  res.render('user/show', { listHis, user })
});

router.get('/edit/:id', async (req, res) => {
    let id = req.params.id;
    // console.log("idd",id);
    let user = await User.find({_id: id});
    console.log("fasgas",user);
    res.render('users/editUser', { user: user });
});

router.post('/edit/:id', async (req, res) => {
    let user_id = req.params.id;
    let admin_id = req.session.userId;
    // console.log(req.session.userId,"ppp");
    let current_account = await User.find({_id: admin_id})
    if (current_account[0].role === 'admin'){
        await User.find({_id: user_id})
        .update(
            [
                {
                    $set: {
                        name: req.body.name,
                        email : req.body.email
                    }
                }
            ]
        )
    }

    res.redirect('/listUser');
  });
router.post('/delete/:id', async (req, res) => {
    let user_id = req.params.id;
    let admin_id = req.session.userId;
    // console.log(req.session.userId,"ppp");
    let current_account = await User.find({_id: admin_id})
    if (current_account[0].role === 'admin'){
        await User.findByIdAndDelete(user_id)
    }
res.redirect('/listUser')
})

module.exports = router;



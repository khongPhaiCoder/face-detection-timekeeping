const mongoose = require("mongoose");

const historySchema = new mongoose.Schema({
  hitories: [
    {
      time: { type: String, required: false },
      status: {
        type: String,
        required: false,
        enum: ['CHECKIN', 'CHECKOUT', 'ABSENT', 'UNKNOW'],
      },
    },
  ],
  absent: {
    type: String,
    required: false,
    default: 'none',
  },
  date: { type: String, required: false },
  time: { type: String, required: false },
  user: {
    type: "ObjectId",
    ref: 'User',
  },
});

const History = mongoose.model('History', historySchema);
// export default History;
module.exports = History;

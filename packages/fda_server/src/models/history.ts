import mongoose, { Schema } from 'mongoose';
import { HistoryType } from '../types/enum.types';

const historySchema = new Schema({
  hitories: [
    {
      time: { type: Schema.Types.String, required: false },
      status: { type: Schema.Types.String, required: false, enum: Object.values(HistoryType) },
    },
  ],
  absent: {
    type: Schema.Types.String,
    required: false,
    default: 'none',
  },
  date: { type: Schema.Types.String, required: false },
  time: { type: Schema.Types.String, required: false, default: '0' },
  user: {
    type: Schema.Types.ObjectId,
    ref: 'User',
  },
});

const History = mongoose.model<any & Document>('History', historySchema);
export default History;

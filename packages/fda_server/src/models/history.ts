import mongoose, { Schema } from 'mongoose';
import { HistoryType } from '../types/enum.types';

const historySchema = new Schema({
  date: { type: Schema.Types.String, required: false },
  time: { type: Schema.Types.String, required: false },
  status: { type: Schema.Types.String, required: false, enum: Object.values(HistoryType) },
  user: {
    type: Schema.Types.ObjectId,
    ref: 'User',
  },
});

const History = mongoose.model<any & Document>('History', historySchema);
export default History;

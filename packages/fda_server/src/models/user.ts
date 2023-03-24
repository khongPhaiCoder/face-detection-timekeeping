import mongoose, { Schema } from 'mongoose';

const userSchema = new Schema({
  name: { type: Schema.Types.String, required: false },
  username: { type: Schema.Types.String, required: false },
  email: { type: Schema.Types.String, required: false },
  password: { type: Schema.Types.String, required: true },
  // status: Joi.string().valid('staff', 'admin', {
  //   _mongoose: { default: 'staff' },
  // }),
});

const User = mongoose.model<any & Document>('User', userSchema);
export default User;

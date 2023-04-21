import mongoose, { Schema } from 'mongoose';

const userSchema = new Schema({
  name: { type: Schema.Types.String, required: false },
  username: { type: Schema.Types.String, required: false },
  email: { type: Schema.Types.String, required: false },
  password: { type: Schema.Types.String, required: true },
  salaryBase: { type: Schema.Types.String, required: true },
  token: [Schema.Types.String],
  faceDescriptors: { type: Object, required: false },
  imageTraining: [{ type: String, required: false }],
  // status: Joi.string().valid('staff', 'admin', {
  //   _mongoose: { default: 'staff' },
  // }),
});

const User = mongoose.model<any & Document>('User', userSchema);
export default User;

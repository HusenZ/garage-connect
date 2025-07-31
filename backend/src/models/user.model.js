import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String },
  googleId: { type: String },
  role: { type: String, enum: ['USER', 'GARAGE_OWNER'], default: 'USER' }
}, { timestamps: true });

export default mongoose.model('User', userSchema);
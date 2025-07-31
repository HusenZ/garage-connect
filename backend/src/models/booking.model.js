import mongoose from 'mongoose';

const bookingSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  garage: { type: mongoose.Schema.Types.ObjectId, ref: 'Garage', required: true },
  service: { type: String, required: true },
  bookingDate: { type: Date, required: true },
  status: { 
    type: String, 
    enum: ['PENDING', 'CONFIRMED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'], 
    default: 'PENDING' 
  },
  notes: { type: String }
}, { timestamps: true });

export default mongoose.model('Booking', bookingSchema);
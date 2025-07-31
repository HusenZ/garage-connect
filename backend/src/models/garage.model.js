import mongoose from 'mongoose';

const garageSchema = new mongoose.Schema({
  owner: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  garageName: { type: String, required: true },
  garagePhone: { type: String, required: true },
  garageAddress: { type: String, required: true },
  garageType: { type: String, enum: ['CAR', 'BIKE'], required: true },
  services: [{ type: String, required: true }],
  location: {
    lat: { type: Number, required: true },
    lng: { type: Number, required: true }
  }
}, { timestamps: true });

export default mongoose.model('Garage', garageSchema);
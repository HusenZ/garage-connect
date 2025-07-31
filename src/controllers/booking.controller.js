import Booking from '../models/booking.model.js';
import Garage from '../models/garage.model.js';

export const createBooking = async (req, res) => {
  try {
    const { garageId, service, bookingDate, notes } = req.body;
    
    const garage = await Garage.findById(garageId);
    if (!garage) {
      return res.status(404).json({ error: 'Garage not found' });
    }
    
    if (!garage.services.includes(service)) {
      return res.status(400).json({ error: 'Service not offered by this garage' });
    }
    
    const booking = new Booking({
      user: req.user.userId,
      garage: garageId,
      service,
      bookingDate: new Date(bookingDate),
      notes
    });
    
    await booking.save();
    await booking.populate(['user', 'garage']);
    
    // Get io instance from app
    const io = req.app.get('io');
    io.emit(`garage_${garageId}`, {
      type: 'NEW_BOOKING',
      booking
    });
    
    res.status(201).json({ message: 'Booking created successfully', booking });
  } catch (error) {
    res.status(500).json({ error: 'Server error creating booking' });
  }
};

export const getUserBookings = async (req, res) => {
  try {
    const bookings = await Booking.find({ user: req.user.userId })
      .populate('garage', 'garageName garageAddress garagePhone')
      .sort('-createdAt');
    
    res.json({ bookings });
  } catch (error) {
    res.status(500).json({ error: 'Server error fetching bookings' });
  }
};

export const getGarageBookings = async (req, res) => {
  try {
    const garage = await Garage.findOne({ owner: req.user.userId });
    if (!garage) {
      return res.status(404).json({ error: 'No garage found' });
    }
    
    const bookings = await Booking.find({ garage: garage._id })
      .populate('user', 'name email')
      .sort('-createdAt');
    
    res.json({ bookings });
  } catch (error) {
    res.status(500).json({ error: 'Server error fetching garage bookings' });
  }
};

export const updateBookingStatus = async (req, res) => {
  try {
    const { status } = req.body;
    
    const garage = await Garage.findOne({ owner: req.user.userId });
    if (!garage) {
      return res.status(404).json({ error: 'No garage found' });
    }
    
    const booking = await Booking.findOne({ 
      _id: req.params.id, 
      garage: garage._id 
    }).populate(['user', 'garage']);
    
    if (!booking) {
      return res.status(404).json({ error: 'Booking not found' });
    }
    
    booking.status = status;
    await booking.save();
    
    const io = req.app.get('io');
    io.emit(`user_${booking.user._id}`, {
      type: 'BOOKING_STATUS_UPDATE',
      booking
    });
    
    res.json({ message: 'Booking status updated successfully', booking });
  } catch (error) {
    res.status(500).json({ error: 'Server error updating booking status' });
  }
};
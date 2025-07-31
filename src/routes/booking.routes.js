import express from 'express';
import { body } from 'express-validator';
import { 
  createBooking, 
  getUserBookings, 
  getGarageBookings, 
  updateBookingStatus 
} from '../controllers/booking.controller.js';
import { authenticateToken, requireRole } from '../middleware/auth.js';
import { handleValidationErrors } from '../middleware/validation.js';

const router = express.Router();

router.post('/', authenticateToken, requireRole('USER'), [
  body('garageId').notEmpty().withMessage('Garage ID is required'),
  body('service').notEmpty().withMessage('Service is required'),
  body('bookingDate').isISO8601().withMessage('Valid booking date is required'),
  body('notes').optional().isString()
], handleValidationErrors, createBooking);

router.get('/my-bookings', authenticateToken, requireRole('USER'), getUserBookings);
router.get('/garage-bookings', authenticateToken, requireRole('GARAGE_OWNER'), getGarageBookings);

router.patch('/:id/status', authenticateToken, requireRole('GARAGE_OWNER'), [
  body('status').isIn(['PENDING', 'CONFIRMED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'])
    .withMessage('Invalid status')
], handleValidationErrors, updateBookingStatus);

export default router;
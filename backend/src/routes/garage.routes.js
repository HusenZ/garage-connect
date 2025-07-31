import express from 'express';
import { body } from 'express-validator';
import { 
  createOrUpdateGarage, 
  getMyGarage, 
  getNearbyGarages, 
  getGarageById 
} from '../controllers/garage.controllers.js';
import { authenticateToken, requireRole } from '../middleware/auth.js';
import { handleValidationErrors } from '../middleware/validation.js';

const router = express.Router();

router.post('/', authenticateToken, requireRole('GARAGE_OWNER'), [
  body('garageName').notEmpty().withMessage('Garage name is required'),
  body('garagePhone').notEmpty().withMessage('Phone number is required'),
  body('garageAddress').notEmpty().withMessage('Address is required'),
  body('garageType').isIn(['CAR', 'BIKE']).withMessage('Garage type must be CAR or BIKE'),
  body('services').isArray({ min: 1 }).withMessage('At least one service is required'),
  body('location.lat').isFloat().withMessage('Valid latitude is required'),
  body('location.lng').isFloat().withMessage('Valid longitude is required')
], handleValidationErrors, createOrUpdateGarage);

router.get('/my-garage', authenticateToken, requireRole('GARAGE_OWNER'), getMyGarage);
router.get('/nearby', authenticateToken, getNearbyGarages);
router.get('/:id', authenticateToken, getGarageById);

export default router;
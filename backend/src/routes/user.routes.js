import express from 'express';
import { body } from 'express-validator';
import { getProfile, updateProfile } from '../controllers/user.controllers.js';
import { authenticateToken } from '../middleware/auth.js';
import { handleValidationErrors } from '../middleware/validation.js';

const router = express.Router();

router.get('/profile', authenticateToken, getProfile);
router.patch('/profile', authenticateToken, [
  body('name').optional().notEmpty().withMessage('Name cannot be empty')
], handleValidationErrors, updateProfile);

export default router;
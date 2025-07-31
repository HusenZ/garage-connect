import express from 'express';
import passport from 'passport';
import { body } from 'express-validator';
import { register, login, googleCallback } from '../controllers/auth.controllers.js';
import { handleValidationErrors } from '../middleware/validation.js';

const router = express.Router();

router.post('/register', [
  body('name').notEmpty().withMessage('Name is required'),
  body('email').isEmail().withMessage('Valid email is required'),
  body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
  body('role').isIn(['USER', 'GARAGE_OWNER']).withMessage('Role must be USER or GARAGE_OWNER')
], handleValidationErrors, register);

router.post('/login', [
  body('email').isEmail().withMessage('Valid email is required'),
  body('password').notEmpty().withMessage('Password is required')
], handleValidationErrors, login);

router.get('/google', passport.authenticate('google', { scope: ['profile', 'email'] }));
router.get('/google/callback', passport.authenticate('google', { session: false }), googleCallback);

export default router;
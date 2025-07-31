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

router.get('/google', (req, res, next) => {
  if (!process.env.GOOGLE_CLIENT_ID) {
    return res.status(501).json({ error: 'Google OAuth not configured' });
  }
  passport.authenticate('google', { scope: ['profile', 'email'] })(req, res, next);
});

router.get('/google/callback', (req, res, next) => {
  if (!process.env.GOOGLE_CLIENT_ID) {
    return res.status(501).json({ error: 'Google OAuth not configured' });
  }
  
  // Call passport authenticate and handle the result
  passport.authenticate('google', { session: false }, (err, user, info) => {
    if (err) return next(err);
    
    // Manually attach user to req and call your controller
    req.user = user;
    googleCallback(req, res, next);
  })(req, res, next);
});

export default router;
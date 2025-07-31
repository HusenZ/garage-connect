import express from 'express';
import cors from 'cors';
import http from 'http';
import { Server as SocketIOServer } from 'socket.io';
import passport from 'passport';
import dotenv from 'dotenv';

// Import configurations
import connectDB from './config/db.js';
import './config/passport.js';

// Import routes
import authRoutes from './routes/auth.routes.js';
import garageRoutes from './routes/garage.routes.js';
import bookingRoutes from './routes/booking.routes.js';
import userRoutes from './routes/user.routes.js';

dotenv.config();

const app = express();
const server = http.createServer(app);
const io = new SocketIOServer(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});

// Connect to MongoDB
connectDB();

// Middleware
app.use(cors());
app.use(express.json());
app.use(passport.initialize());

// Make io available to controllers
app.set('io', io);

// Routes
console.log('Registering auth routes...');
app.use('/api/auth', authRoutes);

console.log('Registering garage routes...');
app.use('/api/garages', garageRoutes);

console.log('Registering booking routes...');
app.use('/api/bookings', bookingRoutes);

console.log('Registering user routes...');
app.use('/api', userRoutes);

console.log('All routes registered successfully!');

// Socket.IO for real-time updates
io.on('connection', (socket) => {
  console.log('User connected:', socket.id);
  
  socket.on('join_room', (room) => {
    socket.join(room);
    console.log(`User ${socket.id} joined room ${room}`);
  });
  
  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.id);
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});


const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

export default app;
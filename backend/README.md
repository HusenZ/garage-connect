# Garage Services Backend API

A comprehensive Node.js backend API for a garage services application that connects garage owners with customers seeking automotive repair services.

---

## 🚀 Features

### 🔐 Authentication & Authorization
- JWT-based auth with email/password
- Google OAuth 2.0 login support
- Role-based access: **User** & **Garage Owner**
- Secure password hashing with bcrypt

### 🧰 Garage Management
- Garage owners can manage their garage profile
- Location-based garage discovery via coordinates
- Filter garages by type: CAR / BIKE
- Full CRUD for garage services

### 📅 Booking System
- Users can book services from garages
- Real-time booking status via **Socket.IO**
- Status flow: `PENDING` → `CONFIRMED` → `IN_PROGRESS` → `COMPLETED`
- Booking history, notes, and time slot support

### 📍 Location Services
- Proximity-based search with Haversine formula
- Radius-based filtering by coordinates and garage type

### 📡 Real-time Features
- Live booking alerts for garage owners
- Booking status updates for users
- WebSocket support with Socket.IO

---

## 🛠️ Tech Stack

| Layer         | Technology           |
|---------------|----------------------|
| Runtime       | Node.js (ES6)        |
| Framework     | Express.js           |
| Database      | MongoDB + Mongoose   |
| Auth          | JWT, Passport (Google OAuth) |
| Real-time     | Socket.IO            |
| Validation    | express-validator    |
| Security      | bcrypt, CORS         |

---

## 📁 Project Structure

```bash
garage-services-backend/
├── server.js                 # Entry point
├── config/
│   ├── database.js           # MongoDB setup
│   └── passport.js           # Google OAuth
├── models/
│   ├── User.js
│   ├── Garage.js
│   └── Booking.js
├── controllers/
│   ├── authController.js
│   ├── garageController.js
│   ├── bookingController.js
│   └── userController.js
├── routes/
│   ├── authRoutes.js
│   ├── garageRoutes.js
│   ├── bookingRoutes.js
│   └── userRoutes.js
├── middleware/
│   ├── auth.js
│   └── validation.js
└── utils/
    └── helpers.js

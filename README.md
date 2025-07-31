# 🚗 Garage Connect — Full Stack App

Garage Connect is a full-stack application built using **Flutter (frontend)** and **Node.js + MongoDB (backend)**. It connects garage owners with users who are seeking automotive repair services nearby.

---

## 🌟 Features

### 🧑‍🔧 Garage Owners
- Register and manage garage profile
- Add available services (Oil Change, Engine Repair, etc.)
- View and manage customer bookings
- Real-time status updates: `PENDING → CONFIRMED → IN_PROGRESS → COMPLETED`

### 🙋 Users
- Register/login
- View nearby garages (based on location and vehicle type: CAR/BIKE)
- Browse services offered by each garage
- Book a service and track repair status in real time

### 🔁 Real-time Functionality
- Live booking notifications using **Socket.IO**
- Real-time repair status tracking for users

---

## 🛠️ Tech Stack

| Layer      | Technology                      |
|------------|----------------------------------|
| Frontend   | Flutter (Dart)                  |
| Backend    | Node.js + Express.js            |
| Database   | MongoDB + Mongoose              |
| Auth       | JWT + Google OAuth (Passport.js)|
| Real-time  | Socket.IO                       |
| Dev Tools  | Postman, VS Code, GitHub        |
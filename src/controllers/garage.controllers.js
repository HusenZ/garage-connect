import Garage from '../models/garage.model.js';
import { calculateDistance } from '../utils/helper.js';

export const createOrUpdateGarage = async (req, res) => {
  try {
    const { garageName, garagePhone, garageAddress, garageType, services, location } = req.body;
    
    let garage = await Garage.findOne({ owner: req.user.userId });
    
    if (garage) {
      garage.garageName = garageName;
      garage.garagePhone = garagePhone;
      garage.garageAddress = garageAddress;
      garage.garageType = garageType;
      garage.services = services;
      garage.location = location;
      await garage.save();
      
      res.json({ message: 'Garage updated successfully', garage });
    } else {
      garage = new Garage({
        owner: req.user.userId,
        garageName,
        garagePhone,
        garageAddress,
        garageType,
        services,
        location
      });
      await garage.save();
      
      res.status(201).json({ message: 'Garage created successfully', garage });
    }
  } catch (error) {
    res.status(500).json({ error: 'Server error managing garage' });
  }
};

export const getMyGarage = async (req, res) => {
  try {
    const garage = await Garage.findOne({ owner: req.user.userId });
    if (!garage) {
      return res.status(404).json({ error: 'No garage found' });
    }
    res.json({ garage });
  } catch (error) {
    res.status(500).json({ error: 'Server error fetching garage' });
  }
};

export const getNearbyGarages = async (req, res) => {
  try {
    const { lat, lng, type, radius = 10 } = req.query;
    
    let query = {};
    if (type && ['CAR', 'BIKE'].includes(type.toUpperCase())) {
      query.garageType = type.toUpperCase();
    }
    
    let garages = await Garage.find(query).populate('owner', 'name email');
    
    if (lat && lng) {
      const userLat = parseFloat(lat);
      const userLng = parseFloat(lng);
      const radiusKm = parseFloat(radius);
      
      garages = garages.filter(garage => {
        const distance = calculateDistance(userLat, userLng, garage.location.lat, garage.location.lng);
        return distance <= radiusKm;
      }).map(garage => ({
        ...garage.toObject(),
        distance: calculateDistance(userLat, userLng, garage.location.lat, garage.location.lng)
      })).sort((a, b) => a.distance - b.distance);
    }
    
    res.json({ garages });
  } catch (error) {
    res.status(500).json({ error: 'Server error fetching garages' });
  }
};

export const getGarageById = async (req, res) => {
  try {
    const garage = await Garage.findById(req.params.id).populate('owner', 'name email');
    if (!garage) {
      return res.status(404).json({ error: 'Garage not found' });
    }
    res.json({ garage });
  } catch (error) {
    res.status(500).json({ error: 'Server error fetching garage details' });
  }
};
import User from '../models/user.model.js';

export const getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.user.userId).select('-password');
    res.json({ user });
  } catch (error) {
    res.status(500).json({ error: 'Server error fetching profile' });
  }
};

export const updateProfile = async (req, res) => {
  try {
    const { name } = req.body;
    
    const user = await User.findById(req.user.userId);
    if (name) user.name = name;
    
    await user.save();
    
    res.json({ message: 'Profile updated successfully', user: { 
      id: user._id, 
      name: user.name, 
      email: user.email, 
      role: user.role 
    }});
  } catch (error) {
    res.status(500).json({ error: 'Server error updating profile' });
  }
};
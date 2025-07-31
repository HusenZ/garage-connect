import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<Map<String, dynamic>?> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken'); 

    if (token == null) return null;

    final response = await http.get(
      Uri.parse('http://localhost:3000/api/profile'), 
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['user']; 
    } else {
      print('Failed to fetch user: ${response.body}');
      return null;
    }
  }
}

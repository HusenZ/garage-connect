import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://10.0.2.2:3000/api/auth';

  Future<String> registerUser(String username, String email, String password, String role) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': username,
          'email': email,
          'password': password,
          'role':role
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        await _saveToken(data['token']);
        await _setLoginStatus(true);
        return "success";
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Registration failed';
      }
    } catch (e) {
      print(e);
      return 'An error occurred:: $e';
    }
  }

  Future<String> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _saveToken(data['token']);
        await _setLoginStatus(true);
        return "success";
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Login failed';
      }
    } catch (e) {
      return 'An error occurred';
    }
  }

  Future<void> logoutUser() async {
    await _removeToken();
    await _setLoginStatus(false);
  }

  // ----------------- Local Storage Helpers -----------------

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<void> _setLoginStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}

import 'dart:convert';
import 'package:garage_app/private.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingService {
  static Future<String> bookService({
    required String garageId,
    required String service,
    required DateTime bookingDate,
    String? notes,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) return 'User not authenticated';

    final response = await http.post(
      Uri.parse('http://$ip:3000/api/bookings'), // Replace with production URL
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'garageId': garageId,
        'service': service,
        'bookingDate': bookingDate.toIso8601String(),
        'notes': notes ?? "note",
      }),
    );

    if (response.statusCode == 201) {
      return 'success';
    } else {
      final error = jsonDecode(response.body);
      return error['error'] ?? 'Booking failed';
    }
  }
static Stream<List<Map<String, dynamic>>> getPendingBookingsStream({Duration interval = const Duration(seconds: 5)}) async* {
    while (true) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if (token == null) {
          throw Exception("Access token missing");
        }

        final response = await http.get(
          Uri.parse('http://$ip:3000/bookings/pending'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final List data = jsonDecode(response.body)['bookings'];
          yield data.map((e) => e as Map<String, dynamic>).toList();
        } else {
          print('Server error: ${response.statusCode}');
          yield [];
        }
      } catch (e) {
        print('Stream error in getPendingBookings: $e');
        yield [];
      }

      await Future.delayed(interval);
    }
  }
  static Future<List<Map<String, dynamic>>> getUserBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) return [];

    final response = await http.get(
      Uri.parse('http://$ip:3000/api/bookings/my-bookings'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['bookings']);
    } else {
      print('Error: ${response.body}');
      return [];
    }
  }
}

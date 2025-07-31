import 'package:flutter/material.dart';
import 'package:garage_app/utils/booking_service.dart';

class UBookingScreen extends StatelessWidget {
  const UBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingService = BookingService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Pending Bookings"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: BookingService.getPendingBookingsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No pending bookings"));
          }

          final bookings = snapshot.data!;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.build_circle_rounded,
                      color: Colors.orange),
                  title: Text(booking['service'] ?? "No service name"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Garage: ${booking['garageName'] ?? ''}"),
                      Text("Status: ${booking['status']}"),
                      if (booking['timestamp'] != null)
                        Text(
                          "Date: ${booking['timestamp'].toDate().toLocal()}",
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

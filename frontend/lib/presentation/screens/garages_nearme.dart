import 'package:flutter/material.dart';
import 'package:garage_app/core/garages_c.dart';
import 'package:garage_app/presentation/screens/book_service_screen.dart';

class GarageNearMeScreen extends StatelessWidget {
  const GarageNearMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    final carGarages =
        garages.where((garage) => garage['type'] == 'CAR').toList();
    final bikeGarages =
        garages.where((garage) => garage['type'] == 'BIKE').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Near me'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "🚗 Car Workshops",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...carGarages.map((garage) => GarageCard(garage: garage)),
          const SizedBox(height: 24),
          const Text(
            "🏍️ Bike Workshops",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...bikeGarages.map((garage) => GarageCard(garage: garage)),
        ],
      ),
    );
  }
}


class GarageCard extends StatelessWidget {
  final Map<String, dynamic> garage;

  const GarageCard({super.key, required this.garage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
  onTap: 
  () {
    
    Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen(garage: garage),));
  },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            // Header bar with avatar and type
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Image.asset(
                        garage['iconPath'], // Use asset path instead of IconData
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Text(
                    '${garage['type'].toString().toUpperCase()} WORKSHOP',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
      
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Garage name and ID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Garage Name',
                          style: TextStyle(fontSize: 12)),
                      const Text('Garage ID', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        garage['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        garage['id'],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
      
                  // Location and Time
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '.............  ${garage['distance']}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      const Text('Time', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          garage['address'],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Text(
                        garage['time'],
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

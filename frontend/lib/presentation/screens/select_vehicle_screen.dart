import 'package:flutter/material.dart';
import 'package:garage_app/presentation/screens/register_vehicle_screen.dart';
import 'package:sizer/sizer.dart';

class SelectVehicleScreen extends StatelessWidget {
  const SelectVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Select Vehicle'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VehicleCard(
                imagePath: 'assets/images/bike.png',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterVehicleScreen(vehicleType: 'bike'),));
                },
              ),
               SizedBox(height: 5.h),
              VehicleCard(
                imagePath: 'assets/images/car.png', 
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterVehicleScreen(vehicleType: 'Car'),));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const VehicleCard({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.all(30.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Image.asset(
          imagePath,
          height: 20.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterVehicleScreen extends StatefulWidget {
  final String vehicleType; // "Car" or "Bike"

  const RegisterVehicleScreen({super.key, required this.vehicleType});

  @override
  State<RegisterVehicleScreen> createState() => _RegisterVehicleScreenState();
}

class _RegisterVehicleScreenState extends State<RegisterVehicleScreen> {
  String? selectedType;
  String? selectedBrand;
  String? selectedModel;

  final carTypes = ["Sedan", "SUV", "Hatchback", "Convertible"];
  final bikeTypes = ["Scooter", "Cruiser", "Sport", "Commuter"];

  final carBrands = {
    "Sedan": ["Honda City", "Hyundai Verna", "Skoda Slavia"],
    "SUV": ["Toyota Fortuner", "Hyundai Creta", "Tata Harrier"],
    "Hatchback": ["Maruti Swift", "Hyundai i20", "Tata Altroz"],
    "Convertible": ["BMW Z4", "Mercedes C-Class", "Mini Cooper"],
  };

  final bikeBrands = {
    "Scooter": ["Honda Activa", "TVS Jupiter", "Suzuki Access"],
    "Cruiser": ["Royal Enfield Classic 350", "Jawa 42", "Honda H’ness CB350"],
    "Sport": ["KTM RC 200", "Yamaha R15", "TVS Apache RR310"],
    "Commuter": ["Bajaj Platina", "Hero Splendor", "TVS Radeon"],
  };

  List<String> getTypes() => widget.vehicleType == "Car" ? carTypes : bikeTypes;

  List<String> getModels() {
    final map = widget.vehicleType == "Car" ? carBrands : bikeBrands;
    return map[selectedType] ?? [];
  }

  void selectModel() {
    // Your model selection navigation logic
  }

  void selectBrand() {
    // Your brand selection navigation logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bgimage.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25.h),
                    Text(
                      'Register your Vehicle',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Type Dropdown
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      decoration: _inputDecoration(
                        '${widget.vehicleType}-Type',
                      ),
                      items:
                          getTypes()
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                          selectedBrand = null;
                          selectedModel = null;
                        });
                      },
                    ),
                    const SizedBox(height: 15),

                    // Brand
                    GestureDetector(
                      onTap: selectedType != null ? selectBrand : null,
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: _inputDecoration('Select Brand').copyWith(
                            suffixIcon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                            ),
                          ),
                          controller: TextEditingController(
                            text: selectedBrand ?? "",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Model
                    GestureDetector(
                      onTap: selectedType != null ? selectModel : null,
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: _inputDecoration('Select Model').copyWith(
                            suffixIcon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                            ),
                          ),
                          controller: TextEditingController(
                            text: selectedModel ?? "",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Continue
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {}, // Continue logic
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("CONTINUE"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  );
}

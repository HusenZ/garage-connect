import 'package:flutter/material.dart';
import 'package:garage_app/core/all_services_c.dart';
import 'package:garage_app/presentation/screens/garages_nearme.dart';

class UServicesScreen extends StatelessWidget {
  const UServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Category"),
        centerTitle: true,
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: allServices.length,
        itemBuilder: (context, index) {
          final service = allServices[index];
          return ServiceTile(
            iconPath: service['icon']!,
            title: service['title']!,
            subtitle: service['subtitle'],
          );
        },
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? subtitle;

  const ServiceTile({
    super.key,
    required this.iconPath,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.grey.shade100,
        child: Image.asset(iconPath, height: 26),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
       Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => GarageNearMeScreen()));
      },
    );
  }
}

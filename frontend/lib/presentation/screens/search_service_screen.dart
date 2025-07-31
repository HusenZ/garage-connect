import 'package:flutter/material.dart';
import 'package:garage_app/core/all_services_c.dart';

class SearchServiceScreen extends StatefulWidget {
  const SearchServiceScreen({super.key});

  @override
  State<SearchServiceScreen> createState() => _SearchServiceScreenState();
}

class _SearchServiceScreenState extends State<SearchServiceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';


  @override
  Widget build(BuildContext context) {
    final filteredServices = allServices.where((service) {
      final title = service['title']!.toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Services"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredServices.isEmpty
                ? const Center(child: Text('No matching services found.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = filteredServices[index];
                      return ServiceTile(
                        iconPath: service['icon']!,
                        title: service['title']!,
                        subtitle: service['subtitle'],
                      );
                    },
                  ),
          ),
        ],
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
        // TODO: Navigate to detail screen or perform booking
      },
    );
  }
}

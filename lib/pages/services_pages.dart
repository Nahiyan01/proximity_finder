import 'package:flutter/material.dart';
import 'package:proximity_finder/services/barikoi_services.dart';

class ServicesPage extends StatefulWidget {
  final String category;

  ServicesPage({required this.category});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final BarikoiService barikoiService = BarikoiService(
      apiKey:
          "bkoi_b1a2920d9f9013418b492dd13482b83e3b70777e024f6724a747a6e5b8a1a0b4");
  List<Map<String, dynamic>> services = [];
  bool isLoading = false;
  String area = '';
  String errorMessage = '';

  Future<void> fetchServices() async {
    if (area.isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final results = await barikoiService
          .getPlaces('$area ${widget.category.toLowerCase()}');
      print('API Response: $results'); // Debug print to check API response
      setState(() {
        services = results;
        isLoading = false;
        if (services.isEmpty) {
          errorMessage = 'No results found for $area';
        }
      });
    } catch (e) {
      print('Error: $e'); // Debug print to check for errors
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load places';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} in your area'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter area',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                area = value;
              },
              onSubmitted: (value) {
                fetchServices();
              },
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
                  ? Center(child: Text(errorMessage))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          final service = services[index];
                          final address =
                              service['address'] ?? 'No address available';
                          final name = address.split(',')[
                              0]; // Extract the first part of the address as the name
                          return ListTile(
                            leading: Icon(Icons.place),
                            title: Text(name),
                            subtitle: Text(address),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          errorMessage = 'Location services are disabled.';
        });
      }
      return;
    }

    // Request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            errorMessage = 'Location permissions are denied.';
          });
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          errorMessage = 'Location permissions are permanently denied.';
        });
      }
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _fetchNearbyServices(position.latitude, position.longitude);
  }

  Future<void> _fetchNearbyServices(double latitude, double longitude) async {
    if (mounted) {
      setState(() {
        isLoading = true;
        errorMessage = '';
        isSearching = false;
      });
    }

    try {
      final results = await barikoiService.getNearbyPlaces(
          latitude, longitude, widget.category.toLowerCase(), 2.0);
      print('API Response: $results'); // Debug print to check API response
      if (mounted) {
        setState(() {
          services = results;
          isLoading = false;
          if (services.isEmpty) {
            errorMessage = 'No nearby services found.';
          }
        });
      }
    } catch (e) {
      print('Error: $e'); // Debug print to check for errors
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load nearby services.';
        });
      }
    }
  }

  Future<void> fetchServices() async {
    if (area.isEmpty) return;

    if (mounted) {
      setState(() {
        isLoading = true;
        errorMessage = '';
        isSearching = true;
      });
    }

    try {
      final results =
          await barikoiService.getPlaces(area, widget.category.toLowerCase());
      print('API Response: $results'); // Debug print to check API response
      if (mounted) {
        setState(() {
          services = results;
          isLoading = false;
          if (services.isEmpty) {
            errorMessage = 'No results found for $area';
          }
        });
      }
    } catch (e) {
      print('Error: $e'); // Debug print to check for errors
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load places';
        });
      }
    }
  }

  Widget buildNearbyServiceTile(Map<String, dynamic> service) {
    final name = service['name'] ?? 'No name available';
    final address = service['Address'] ?? 'No address available';
    final subType = service['subType'] ?? '';
    final addressWithoutFirstPart = address.contains(',')
        ? address.substring(address.indexOf(',') + 1).trim()
        : address;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subType.isNotEmpty)
              Text(
                subType,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            Text(
              addressWithoutFirstPart,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchResultTile(Map<String, dynamic> service) {
    final address = service['address'] ?? 'No address available';
    final name = address
        .split(',')[0]; // Extract the first part of the address as the name

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        leading: Icon(Icons.place),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          address,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
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
                          return isSearching
                              ? buildSearchResultTile(service)
                              : buildNearbyServiceTile(service);
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

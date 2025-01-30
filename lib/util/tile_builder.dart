import 'package:flutter/material.dart';

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

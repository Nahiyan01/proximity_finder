import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapPage extends StatefulWidget {
  final double currentLatitude;
  final double currentLongitude;
  final double destinationLatitude;
  final double destinationLongitude;
  final List<LatLng> polyline;

  const MapPage({
    super.key,
    required this.currentLatitude,
    required this.currentLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.polyline,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapLibreMapController? mController;

  static const styleId = 'osm-liberty'; // barikoi map style id
  static const apiKey =
      'bkoi_b1a2920d9f9013418b492dd13482b83e3b70777e024f6724a747a6e5b8a1a0b4'; // Replace with your Barikoi API key
  static const mapUrl =
      'https://map.barikoi.com/styles/$styleId/style.json?key=$apiKey';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route to Destination'),
      ),
      body: MapLibreMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(23.91710281311872, 90.23194615791373),
          zoom: 17,
        ),
        onMapCreated: (MapLibreMapController mController) {
          this.mController = mController;
        },
        styleString: mapUrl,
        onStyleLoadedCallback: () {
          mController?.addLine(
            LineOptions(
              geometry: widget.polyline,
              lineColor: "#4CC764", // color of the line, in hex string
              lineWidth: 5.0, // width of the line
              lineOpacity: 0.5, // transparency of the line
            ),
          );
        },
      ),
    );
  }

  // void _addPolyline() {
  //   print('Adding polyline: ${widget.polyline}'); // Debug print
  //   if (mController != null) {
  //     if (widget.polyline.isNotEmpty) {
  //       mController?.addLine(
  //         LineOptions(
  //           geometry: widget.polyline,
  //           lineColor: "#ff0000", // color of the line, in hex string
  //           lineWidth: 5.0, // width of the line
  //           lineOpacity: 0.8, // transparency of the line
  //         ),
  //       );
  //     } else {
  //       print('Error: Polyline is empty'); // Debug print
  //     }
  //   } else {
  //     print('Error: mController is null'); // Debug print
  //   }
  //}
}

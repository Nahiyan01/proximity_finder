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
  MaplibreMapController? mController;

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
      body: MaplibreMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.currentLatitude, widget.currentLongitude),
          zoom: 12,
        ),
        onMapCreated: (MaplibreMapController mapController) {
          mController = mapController;
          _addCircles();
          _addPolyline();
        },
        styleString: mapUrl,
      ),
    );
  }

  void _addCircles() {
    if (mController != null) {
      mController?.addCircle(
        CircleOptions(
          geometry: LatLng(widget.currentLatitude, widget.currentLongitude),
          circleRadius: 8.0,
          circleColor: "#ff0000", // red color for current location
          circleOpacity: 0.8,
        ),
      );

      mController?.addCircle(
        CircleOptions(
          geometry:
              LatLng(widget.destinationLatitude, widget.destinationLongitude),
          circleRadius: 8.0,
          circleColor: "#0000ff", // blue color for destination location
          circleOpacity: 0.8,
        ),
      );
    }
  }

  void _addPolyline() {
    if (mController != null) {
      mController?.addLine(
        LineOptions(
          geometry: widget.polyline,
          lineColor: "#ff0000", // color of the line, in hex string
          lineWidth: 5.0, // width of the line
          lineOpacity: 0.8, // transparency of the line
        ),
      );
    }
  }
}

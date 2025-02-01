import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapPage extends StatefulWidget {
  final double currentLatitude;
  final double currentLongitude;
  final double destinationLatitude;
  final double destinationLongitude;

  const MapPage({
    super.key,
    required this.currentLatitude,
    required this.currentLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required List<LatLng> polyline,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  CameraPosition initialPosition = CameraPosition(
    target: LatLng(23.915700, 90.235600),
    zoom: 20,
  ); //CameraPosition object for initial location in map
  MaplibreMapController? mController;

  static const styleId = 'osm-liberty'; //barikoi map style id
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
        initialCameraPosition: initialPosition,
        onMapCreated: (MaplibreMapController mapController) {
          mController = mapController;
        },
        styleString: mapUrl,
        onStyleLoadedCallback: () {
          mController?.addLine(
            LineOptions(
              geometry: [
                LatLng(widget.currentLatitude, widget.currentLongitude),
                LatLng(widget.destinationLatitude, widget.destinationLongitude),
              ],
              lineColor: "#ff0000", // color of the line, in hex string
              lineWidth: 1.0, // width of the line
              lineOpacity: 0.5, // transparency of the line
              draggable: false, // set whether line is draggable
            ),
          );
          // add line tap listener
          mController?.onLineTapped.add(_onLineTapped);
        },
      ),
    );
  }

  void _onLineTapped(Line line) {
    // implement line tap event here
  }
}

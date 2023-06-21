import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvince extends StatefulWidget {
  const MapProvince(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  State<MapProvince> createState() => _MapProvince();
}

class _MapProvince extends State<MapProvince> {
  late GoogleMapController mapController;

  LatLng _center = const LatLng(0, 0); // Initialize _center with default values

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.latitude,
        widget.longitude); // Set _center with latitude and longitude
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        elevation: 2,
        backgroundColor: const Color(0xFF676BD0),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}

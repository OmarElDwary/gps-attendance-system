import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeofencePage extends StatefulWidget {
  const GeofencePage({super.key});

  @override
  State<GeofencePage> createState() => _GeofencePageState();
}

class _GeofencePageState extends State<GeofencePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  GoogleMapController? _googleMapController;
  LatLng? _location;
  Set<Circle> _circle = {};

  void _updateCircle(LatLng newLocation) {
    setState(() {
      _circle = {
        Circle(
          circleId: CircleId('value'),
          center: newLocation,
          radius: 100,
          strokeWidth: 2,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.3),
        ),
      };
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void _onMapTap(LatLng loc) {
    setState(() {
      _location = loc;
      _updateCircle(loc);
    });
  }

  void _saveLocation() async {
    if (_location == null) return;
    await _firestore.collection('company-location').doc('company-location').set(
        {'latitude': _location!.latitude, 'longitude': _location!.longitude});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('New Geofence added succusfully'),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geofence'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            onTap: _onMapTap,
            initialCameraPosition:
                CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 15),
            markers: _location == null
                ? {}
                : {
                    Marker(
                      markerId: const MarkerId('Your Company'),
                      position: _location!,
                    ),
                  },
            circles: _circle,
          ),
          if (_location != null)
            Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
                  onPressed: _saveLocation, child: Text('Save Location')),
            )
        ],
      ),
    );
  }
}

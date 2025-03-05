import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserMap extends StatefulWidget {
  const UserMap({Key? key}) : super(key: key);

  @override
  State<UserMap> createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polylinesCoordinates = [];
  static const LatLng sourceLocation = LatLng(37.4220, -122.0841);
  static const LatLng destination = LatLng(37.4220, -122.0641);
  static const String api_key =
      "AIzaSyDGgdRe025Dlu13ywAN1cws5CUygc_JBmo"; // Store securely

  Future<void> getPolyPoints() async {
    PolylinePoints polyLinePoints = PolylinePoints();
    try {
      final result = await polyLinePoints.getRouteBetweenCoordinates(
        api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
      );

      if (result.status == 'OK' && result.points.isNotEmpty) {
        setState(() {
          polylinesCoordinates.addAll(result.points
              .map((point) => LatLng(point.latitude, point.longitude)));
        });
      } else {
        print('Failed to get route: ${result.status}');
      }
    } catch (e) {
      print('Error getting route: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Map'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: sourceLocation,
            zoom: 13.5,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          polylines: {
            Polyline(
              polylineId: const PolylineId('route'),
              points: polylinesCoordinates,
              color: Colors.red,
              width: 6,
            ),
          },
          markers: {
            const Marker(
              markerId: MarkerId('source'),
              position: sourceLocation,
              infoWindow: InfoWindow(title: 'Source Location'),
            ),
            const Marker(
              markerId: MarkerId('destination'),
              position: destination,
              infoWindow: InfoWindow(title: 'Destination'),
            ),
          },
        ),
      ),
    );
  }
}

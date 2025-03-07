import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CompanyLocation extends StatelessWidget {
  const CompanyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: 200, // Set a fixed height
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.0447, 31.2389),
              zoom: 14,
            ),
            markers: {
              const Marker(
                markerId: MarkerId('Greek Campus'),
                position: LatLng(30.0447, 31.2389),
              ),
            },
            zoomControlsEnabled: false,
          ),
        ),
      ),
    );
  }
}

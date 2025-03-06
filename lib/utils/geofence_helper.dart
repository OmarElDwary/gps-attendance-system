import 'package:geolocator/geolocator.dart';

Future<bool> isWithinGeofence(Position userPosition) async {
  const double geofenceCenterLat = 30.0459;
  const double geofenceCenterLon = 31.2243;
  const double geofenceRadiusInMeters = 100.0; // 100 meters

  double distance = Geolocator.distanceBetween(
    userPosition.latitude,
    userPosition.longitude,
    geofenceCenterLat,
    geofenceCenterLon,
  );
  return distance <= geofenceRadiusInMeters;
}

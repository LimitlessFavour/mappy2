import 'package:location/location.dart';

Future<LocationData> getCurrentLocation() async {
  final location = Location();

  bool isServiceEnabled = await location.serviceEnabled();
  if (!isServiceEnabled) {
    isServiceEnabled = await location.requestService();
    if (!isServiceEnabled) {
      throw LocationException('Location services are disabled');
    }
  }

  PermissionStatus permissionStatus = await location.hasPermission();
  if (permissionStatus == PermissionStatus.denied) {
    permissionStatus = await location.requestPermission();
    if (permissionStatus != PermissionStatus.granted) {
      throw LocationException('Location permission denied');
    }
  }

  return location.getLocation();
}

class LocationException implements Exception {
  final String message;

  LocationException(this.message);
}

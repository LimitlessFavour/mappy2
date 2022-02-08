import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mappy2/utils/location.util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const CameraPosition _defaultCameraPosition = CameraPosition(
    target: LatLng(0.0, 0.0),
  );

  late final MapboxMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken: const String.fromEnvironment('ACCESS_TOKEN'),
        initialCameraPosition: _defaultCameraPosition,
        onMapCreated: (MapboxMapController controller) async {
          _mapController = controller;

          final location = await getCurrentLocation();
          _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  location.latitude ?? 0.0,
                  location.longitude ?? 0.0,
                ),
                zoom: 12.0,
              ),
            ),
          );
        },
      ),
    );
  }
}

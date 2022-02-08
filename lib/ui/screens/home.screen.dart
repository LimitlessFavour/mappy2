import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mappy2/data/blocs/data.cubit.dart';
import 'package:mappy2/data/blocs/data.state.dart';
import 'package:mappy2/data/models/feature.model.dart';
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

  MapboxMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DataCubit, DataState>(
        listener: (BuildContext context, DataState state) {
          if (state.status == DataStatus.successful) {
            final features = state.response?.features ?? <FeatureModel>[];

            _mapController?.addSymbols(
              features
                  .map(
                    (FeatureModel element) => SymbolOptions(
                      geometry: element.coordinates,
                      iconImage: 'assets/location_pin.png',
                      draggable: false,
                    ),
                  )
                  .toList(),
            );
            _mapController?.onSymbolTapped.add((Symbol argument) {
              final symbolLocation = argument.options.geometry;
              if (symbolLocation != null) {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLng(symbolLocation),
                );

                final pointOfInterest = features[int.parse(argument.id)];
                if (pointOfInterest.pointID.isNotEmpty) {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(pointOfInterest.title),
                      content: Text(pointOfInterest.fullPlaceName),
                    ),
                  );
                }
              }
            });
          } else if (state.status == DataStatus.failed) {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: Text(
                  state.errorMessage ?? 'Unknown application exception',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: MapboxMap(
          accessToken: const String.fromEnvironment('ACCESS_TOKEN'),
          initialCameraPosition: _defaultCameraPosition,
          myLocationEnabled: true,
          onMapCreated: (MapboxMapController controller) async {
            _mapController = controller;

            final location = await getCurrentLocation();
            BlocProvider.of<DataCubit>(context).fetchPointsOfInterest(
              LatLng(
                location.latitude ?? 0.0,
                location.longitude ?? 0.0,
              ),
            );

            _mapController?.animateCamera(
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
          onMapClick: (_, LatLng location) {},
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mappy2/data/data.repository.dart';

void main() {
  test(
    'Fetch points of interest',
    () async {
      final repository = DataRepository();

      final pointsOfInterest = await repository.fetchPointsOfInterest(
        const LatLng(46.0569, 14.5058),
      );
      for (var feature in pointsOfInterest.features) {
        print(feature.pointID);
        print('${feature.title}, ${feature.coordinates.toString()}\n');
      }

      expect(pointsOfInterest.features.isNotEmpty, true);
    },
  );
}

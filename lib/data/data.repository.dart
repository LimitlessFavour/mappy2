import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:loggy/loggy.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mappy2/data/models/response.model.dart';

Future<ResponseModel> _fetchPointsOfInterestIsolate(LatLng location) async {
  final response = await get(
    Uri.https(
      'api.mapbox.com',
      'geocoding/v5/mapbox.places/${location.longitude},${location.latitude}.json',
      <String, String>{
        'access_token': const String.fromEnvironment('ACCESS_TOKEN'),
        'limit': 5.toString(),
        'types': 'poi',
      },
    ),
    headers: {HttpHeaders.contentTypeHeader: ContentType.json.toString()},
  );

  logDebug('API request came back with ${response.statusCode}');
  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw Exception(
      '${response.statusCode}: Failed to fetch points of interest',
    );
  }

  final rawResponse = json.decode(response.body) as Map<String, dynamic>;
  return ResponseModel.fromJson(rawResponse);
}

abstract class IDataRepository {
  Future<ResponseModel> fetchPointsOfInterest(LatLng location);
}

class DataRepository implements IDataRepository {
  @override
  Future<ResponseModel> fetchPointsOfInterest(LatLng location) {
    return compute<LatLng, ResponseModel>(
      _fetchPointsOfInterestIsolate,
      location,
    );
  }
}

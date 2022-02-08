import 'package:json_annotation/json_annotation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class CoordinatesConverter implements JsonConverter<LatLng, List<dynamic>> {
  const CoordinatesConverter();

  @override
  LatLng fromJson(List<dynamic> json) {
    assert(json.length == 2);
    return LatLng(json[1] as double, json[0] as double);
  }

  @override
  List<dynamic> toJson(LatLng object) {
    return <dynamic>[object.longitude, object.latitude];
  }
}

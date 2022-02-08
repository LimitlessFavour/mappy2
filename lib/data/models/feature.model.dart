import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mappy2/data/converters/coordinates.converter.dart';

part 'feature.model.freezed.dart';
part 'feature.model.g.dart';

@freezed
@immutable
class FeatureModel with _$FeatureModel {
  const factory FeatureModel({
    @JsonKey(name: 'id') required String pointID,
    @JsonKey(name: 'text') required String title,
    @JsonKey(name: 'place_name') required String fullPlaceName,
    @JsonKey(name: 'center')
    @CoordinatesConverter()
        required LatLng coordinates,
  }) = _FeatureModel;

  factory FeatureModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$FeatureModelFromJson(json);
}

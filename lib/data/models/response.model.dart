import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mappy2/data/models/feature.model.dart';

part 'response.model.freezed.dart';
part 'response.model.g.dart';

@freezed
@immutable
class ResponseModel with _$ResponseModel {
  const factory ResponseModel({
    @JsonKey(name: 'features') required List<FeatureModel> features,
    @JsonKey(name: 'attribution') required String attribution,
  }) = _ResponseModel;

  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ResponseModelFromJson(json);
}

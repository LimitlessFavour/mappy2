import 'package:equatable/equatable.dart';
import 'package:mappy2/data/models/response.model.dart';

enum DataStatus { loading, successful, failed }

class DataState extends Equatable {
  final DataStatus status;
  final ResponseModel? response;
  final String? errorMessage;

  const DataState._({
    required this.status,
    this.response,
    this.errorMessage,
  });

  factory DataState.loading() => const DataState._(status: DataStatus.loading);

  factory DataState.successful(ResponseModel data) => DataState._(
        status: DataStatus.successful,
        response: data,
      );

  factory DataState.failed(String errorMessage) => DataState._(
        status: DataStatus.failed,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, response, errorMessage];
}

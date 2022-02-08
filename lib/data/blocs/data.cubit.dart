import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mappy2/data/blocs/data.state.dart';
import 'package:mappy2/data/data.repository.dart';
import 'package:mappy2/dependencies.dart';

class DataCubit extends Cubit<DataState> {
  final IDataRepository _repository;

  DataCubit()
      : _repository = getIt.get<IDataRepository>(),
        super(DataState.loading());

  Future<void> fetchPointsOfInterest(LatLng location) async {
    emit(DataState.loading());
    try {
      final response = await _repository.fetchPointsOfInterest(location);
      logDebug('Found ${response.features.length} points of interest');
      emit(DataState.successful(response));
    } on Exception catch (e) {
      emit(DataState.failed(e.toString()));
    }
  }
}

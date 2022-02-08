import 'package:get_it/get_it.dart';
import 'package:mappy2/data/data.repository.dart';

final GetIt getIt = GetIt.instance;
void registerDependencies() {
  getIt.registerSingleton<IDataRepository>(DataRepository());
}

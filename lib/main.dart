import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';
import 'package:mappy2/data/blocs/data.cubit.dart';
import 'package:mappy2/dependencies.dart';
import 'package:mappy2/ui/app.dart';

void main() {
  Loggy.initLoggy();
  registerDependencies();
  runApp(
    BlocProvider<DataCubit>(
      create: (_) => DataCubit(),
      child: const App(),
    ),
  );
}

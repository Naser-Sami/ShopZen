import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '_app/_app.dart';

Future<void> main() async {
  IServiceInitializer serviceInitializer = ServiceInitializer();
  await serviceInitializer.init();

  runApp(
    MultiBlocProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

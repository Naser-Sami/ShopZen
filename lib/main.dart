import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'core/_core.dart';

import '_app/_app.dart';

Future<void> main() async {
  // -- Add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Ensure Service Locator is Started
  DI().init();

  // Initialize the 'settings' box
  final settingsService = sl<HiveService>();
  await settingsService.init();

  runApp(
    MultiBlocProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

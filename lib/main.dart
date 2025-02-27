import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'features/_features.dart';
import 'firebase_options.dart';
import 'core/_core.dart';

import '_app/_app.dart';

Future<void> main() async {
  // -- Add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;

  // Ensure Service Locator is Started
  DI().init();

  // Initialize Messaging Service
  MessagingConfig.initFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);

  // Register all adapters before using Hive
  registerAllHiveAdapters();

  // Initialize the 'settings' box
  final settingsService = sl<IHiveService>();
  await settingsService.init();

  final productService = sl<IHiveService<ProductEntity>>();
  await productService.init();

  runApp(
    MultiBlocProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/firebase_options.dart';
import '/features/_features.dart' show ProductEntity;
import '/core/_core.dart' show DI, IHiveService, MessagingConfig, StripeService, sl;
import '_app.dart' show registerAllHiveAdapters;

abstract class IServiceInitializer {
  Future<void> init();
  WidgetsBinding get widgetsBinding => WidgetsFlutterBinding.ensureInitialized();
  void initializeSplashScreen();
  void initializePathUrlStrategy();
  void initializeGoRouter();
  Future<void> initializeHydratedBloc();
  Future<void> initializeHive();
  Future<void> initializeDotEnv();
  Future<void> initializeStripe();
  Future<void> initializeFirebase();
  Future<void> initializeFirebaseMessaging();
  void initializeServiceLocator();
  Future<void> initializeThemeHiveService();
  Future<void> initializeProductHiveService();
  void removeSplashScreen();
}

class ServiceInitializer extends IServiceInitializer {
  @override
  Future<void> init() async {
    initializeSplashScreen();
    initializePathUrlStrategy();
    initializeGoRouter();
    await initializeHydratedBloc();
    await initializeHive();
    await initializeDotEnv();
    await initializeStripe();
    await initializeFirebase();
    await initializeFirebaseMessaging();
    initializeServiceLocator();
    await initializeThemeHiveService();
    await initializeProductHiveService();
    removeSplashScreen();
  }

  @override
  void initializeSplashScreen() {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  @override
  void initializePathUrlStrategy() {
    setPathUrlStrategy();
  }

  @override
  void initializeGoRouter() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  @override
  Future<void> initializeHydratedBloc() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory:
          kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
    );
  }

  @override
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    // Register all adapters before using Hive
    registerAllHiveAdapters();
  }

  @override
  Future<void> initializeDotEnv() async {
    await dotenv.load(fileName: "assets/.env");
  }

  @override
  Future<void> initializeStripe() async {
    StripeService.init();
    Stripe.instance.applySettings();
  }

  @override
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<void> initializeFirebaseMessaging() async {
    MessagingConfig.initFirebaseMessaging();
    FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);
  }

  @override
  void initializeServiceLocator() {
    DI().init();
  }

  @override
  Future<void> initializeThemeHiveService() async {
    final themeService = sl<IHiveService>();
    await themeService.init();
  }

  @override
  Future<void> initializeProductHiveService() async {
    final productService = sl<IHiveService<ProductEntity>>();
    await productService.init();
  }

  @override
  void removeSplashScreen() {
    FlutterNativeSplash.remove();
  }
}

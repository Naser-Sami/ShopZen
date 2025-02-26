import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

// Global Variable
// Initialize GetIt
final sl = GetIt.I;

class DI {
  Future<void> init() async {
    // Use registerSingleton when:

    // Use registerLazySingleton when:

    // Dio
    sl.registerLazySingleton<DioHelper>(
      () => DioHelper(),
    );

    // Services

    // Firebase Service
    final firebaseAuth = FirebaseAuth.instance;
    final fireStore = FirebaseFirestore.instance;
    final firebaseMessaging = FirebaseMessaging.instance;

    sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
    sl.registerLazySingleton<FirebaseFirestore>(() => fireStore);
    sl.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);

    sl.registerLazySingleton<IFirebaseAuthService>(
      () => FirebaseAuthServiceImpl(
        auth: firebaseAuth,
      ),
    );

    sl.registerLazySingleton<INotificationsService>(
      () => NotificationsServiceImpl(),
    );

    // Firebase Social Sign In
    sl.registerLazySingleton<ISocialSignInService>(
      () => SocialSignInServiceImpl(
        auth: firebaseAuth,
      ),
    );

    sl.registerSingleton<IFirestoreService<UserModel>>(
      FirestoreServiceImpl<UserModel>(UserModel.fromJson),
    );
    sl.registerSingleton<IFirestoreService<NotificationsModel>>(
      FirestoreServiceImpl<NotificationsModel>(NotificationsModel.fromMap),
    );

    // BLOC's
    sl.registerLazySingleton<ProductsBloc>(
      () => ProductsBloc(productRepository: sl<IProductRepository>()),
    );

    // CUBIT's
    sl.registerLazySingleton<ThemeCubit>(
      () => ThemeCubit(),
    );

    sl.registerLazySingleton<UserCubit>(
      () => UserCubit(),
    );

    sl.registerLazySingleton<SearchLocationCubit>(
      () => SearchLocationCubit(),
    );

    // Local Storage Services
    sl.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(),
    );
    sl.registerLazySingleton<HiveService<dynamic>>(
      () => HiveService<dynamic>(
        boxName: 'settings',
      ),
    );

    // Location Services
    sl.registerLazySingleton<IGeolocatorService>(
      () => GeolocatorServiceImpl(),
    );
    sl.registerLazySingleton<IGeocodingService>(
      () => GeocodingServiceImpl(),
    );
    sl.registerLazySingleton<IGeoCodeService>(
      () => GeoCodeServiceImpl(),
    );

    // Controllers
    sl.registerLazySingleton<AuthController>(
      () => AuthController(),
    );

    // Data Sources
    sl.registerLazySingleton<IProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(),
    );

    // Repositories
    sl.registerLazySingleton<IProductRepository>(
      () => ProductRepositoryImpl(
        remoteDataSource: sl<IProductsRemoteDataSource>(),
      ),
    );

    sl.registerLazySingleton<ICategoriesRepository>(
      () => CategoriesRepositoryImpl(),
    );

    sl.registerLazySingleton<IAccountRepository>(
      () => AccountRepositoryImpl(),
    );

    sl.registerLazySingleton<IHelpCenterRepository>(
      () => HelpCenterRepositoryImpl(),
    );

    sl.registerLazySingleton<IChatRepository>(
      () => ChatRepositoryImpl(),
    );

    // Use cases
  }
}

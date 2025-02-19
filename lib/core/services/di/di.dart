import 'package:firebase_auth/firebase_auth.dart';
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
    sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);

    sl.registerLazySingleton<IFirebaseAuthService>(
      () => FirebaseAuthServiceImpl(
        auth: firebaseAuth,
      ),
    );

    // Firebase Social Sign In
    sl.registerLazySingleton<ISocialSignInService>(
      () => SocialSignInServiceImpl(
        auth: firebaseAuth,
      ),
    );

    // BLOC's
    sl.registerLazySingleton<ProductsBloc>(
      () => ProductsBloc(productRepository: sl<IProductRepository>()),
    );

    // CUBIT's
    sl.registerLazySingleton<ThemeCubit>(
      () => ThemeCubit(),
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

    // Use cases
  }
}

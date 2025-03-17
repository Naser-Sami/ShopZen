import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

// Global Variable
// Initialize GetIt
final sl = GetIt.I;

class DI {
  Future<void> initDio() async {
    sl.registerLazySingleton<DioService>(
      () => DioService(),
    );
  }

  Future<void> initSecureStorageService() async {
    sl.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(),
    );
  }

  Future<void> initHive() async {
    sl.registerLazySingleton<IHiveService<dynamic>>(
      () => HiveService<dynamic>(
        boxName: 'theme',
      ),
    );

    sl.registerLazySingleton<IHiveService<ProductEntity>>(
      () => HiveService<ProductEntity>(
        boxName: 'favorites',
        adapter: ProductEntityAdapter(),
      ),
    );
  }

  Future<void> initFirebase() async {
    final firebaseAuth = FirebaseAuth.instance;
    sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);

    sl.registerLazySingleton<IFirebaseAuthService>(
      () => FirebaseAuthServiceImpl(
        auth: firebaseAuth,
      ),
    );

    sl.registerLazySingleton<ISocialSignInService>(
      () => SocialSignInServiceImpl(
        auth: firebaseAuth,
      ),
    );
  }

  Future<void> initFirebaseFirestore() async {
    final fireStore = FirebaseFirestore.instance;
    sl.registerLazySingleton<FirebaseFirestore>(() => fireStore);
  }

  Future<void> initFirebaseMessaging() async {
    final firebaseMessaging = FirebaseMessaging.instance;

    sl.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);
  }

  Future<void> initServices() async {
    sl.registerLazySingleton<AuthService>(
      () => AuthService(),
    );

    sl.registerLazySingleton<INotificationsService>(
      () => NotificationsServiceImpl(),
    );

    sl.registerSingleton<IFirestoreService<UserModel>>(
      FirestoreServiceImpl<UserModel>(UserModel.fromJson),
    );

    sl.registerSingleton<IFirestoreService<NotificationsModel>>(
      FirestoreServiceImpl<NotificationsModel>(NotificationsModel.fromMap),
    );

    sl.registerLazySingleton<IGeolocatorService>(
      () => GeolocatorServiceImpl(),
    );

    sl.registerLazySingleton<IGeocodingService>(
      () => GeocodingServiceImpl(),
    );

    sl.registerLazySingleton<IGeoCodeService>(
      () => GeoCodeServiceImpl(),
    );
  }

  Future<void> initDataSources() async {
    sl.registerLazySingleton<IProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<ISearchProductRemoteDataSource>(
      () => SearchProductRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<ICartRemoteDataSource>(
      () => CartRemoteDataSource(),
    );
  }

  Future<void> initRepositories() async {
    sl.registerLazySingleton<IProductRepository>(
      () => ProductRepositoryImpl(
        remoteDataSource: sl<IProductsRemoteDataSource>(),
      ),
    );

    sl.registerLazySingleton<IGetProductCategoryListRepository>(
      () => GetProductCategoryListRepositoryImpl(
        remoteDataSource: sl<IProductsRemoteDataSource>(),
      ),
    );

    sl.registerLazySingleton<IGetProductsByCategoryRepository>(
      () => GetProductsByCategoryRepositoryImpl(
        remoteDataSource: sl<IProductsRemoteDataSource>(),
      ),
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

    sl.registerLazySingleton<ISearchProductRepository>(
      () => SearchProductRepositoryImpl(
        remoteDataSource: sl<ISearchProductRemoteDataSource>(),
      ),
    );

    sl.registerLazySingleton<ICartRepository>(
      () => CartRepositoryImpl(
        sl<ICartRemoteDataSource>(),
      ),
    );
  }

  Future<void> initUseCases() async {}

  Future<void> initControllers() async {
    sl.registerLazySingleton<ThemeCubit>(
      () => ThemeCubit(),
    );

    sl.registerLazySingleton<SearchLocationCubit>(
      () => SearchLocationCubit(),
    );

    sl.registerLazySingleton<UserCubit>(
      () => UserCubit(),
    );

    sl.registerFactory<AddressCubit>(
      () => AddressCubit(),
    );

    sl.registerFactory<PaymentCubit>(
      () => PaymentCubit(),
    );

    sl.registerLazySingleton<ProductsBloc>(
      () => ProductsBloc(
        productRepository: sl<IProductRepository>(),
        getProductCategoryListRepository: sl<IGetProductCategoryListRepository>(),
        getProductsByCategoryRepository: sl<IGetProductsByCategoryRepository>(),
      )..add(
          LoadFavoriteProductsEvent(),
        ),
    );

    sl.registerLazySingleton<SearchBloc>(
      () => SearchBloc(
        searchProductRepository: sl<ISearchProductRepository>(),
      ),
    );

    sl.registerLazySingleton<CartBloc>(
      () => CartBloc(
        sl<ICartRepository>(),
      ),
    );
  }

  Future<void> init() async {
    await initServices();
    await initDataSources();
    await initRepositories();
    await initUseCases();
    await initControllers();
    await initDio();
    await initSecureStorageService();
    await initHive();
    await initFirebase();
    await initFirebaseFirestore();
    await initFirebaseMessaging();
  }
}

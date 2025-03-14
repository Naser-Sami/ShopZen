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
  void initDio() {
    sl.registerLazySingleton<DioHelper>(
      () => DioHelper(),
    );
  }

  void initSecureStorageService() {
    sl.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(),
    );
  }

  void initHive() {
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

  void initFirebase() {
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

  void initFirebaseFirestore() {
    final fireStore = FirebaseFirestore.instance;
    sl.registerLazySingleton<FirebaseFirestore>(() => fireStore);
  }

  void initFirebaseMessaging() {
    final firebaseMessaging = FirebaseMessaging.instance;

    sl.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);
  }

  void initControllers() {
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

  void initServices() {
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

  void initDataSources() {
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

  void initRepositories() {
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

  void initUseCases() {}

  Future<void> init() async {
    initDio();
    initSecureStorageService();
    initHive();
    initFirebase();
    initFirebaseFirestore();
    initFirebaseMessaging();
    initControllers();
    initServices();
    initRepositories();
    initUseCases();
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/_features.dart';
import '/config/_config.dart';
import '/core/_core.dart';

final providers = [
  BlocProvider<ThemeCubit>(
    create: (context) => ThemeCubit(),
  ),
  BlocProvider<UserCubit>(
    create: (context) => UserCubit(),
  ),
  BlocProvider<ProductsBloc>(
    create: (context) => ProductsBloc(productRepository: sl<IProductRepository>()),
  ),
];

import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/_features.dart';
import '/config/_config.dart';
import '/core/_core.dart';

final providers = [
  BlocProvider<ThemeCubit>(
    create: (context) => sl<ThemeCubit>(),
  ),
  BlocProvider<UserCubit>(
    create: (context) => sl<UserCubit>(),
  ),
  BlocProvider<ProductsBloc>(
    create: (context) => sl<ProductsBloc>(),
  ),
  BlocProvider<SearchBloc>(
    create: (context) => sl<SearchBloc>(),
  ),
  BlocProvider<SearchLocationCubit>(
    create: (context) => sl<SearchLocationCubit>(),
  ),
  BlocProvider<CartBloc>(
    create: (context) => sl<CartBloc>(),
  ),
  BlocProvider<AddressCubit>(
    create: (context) => sl<AddressCubit>(),
  ),
  BlocProvider<PaymentCubitCubit>(
    create: (context) => sl<PaymentCubitCubit>(),
  ),
];

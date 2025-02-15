import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/_config.dart';

final providers = [
  BlocProvider<ThemeCubit>(
    create: (context) => ThemeCubit(),
  ),
];

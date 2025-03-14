import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toastification/toastification.dart';

// Files
import '/config/_config.dart';
import '/core/_core.dart' show AppConfig;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return ToastificationWrapper(
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: MaterialApp.router(
              title: AppConfig.appName,
              debugShowCheckedModeBanner: false,
              themeMode: state,
              theme: lightTheme,
              darkTheme: darkTheme,
              scrollBehavior: scrollBehavior,
              routerConfig: router,
            ),
          ),
        );
      },
    );
  }
}

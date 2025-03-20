import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart' show SecureStorageService, sl;
import '/config/_config.dart';
import '/features/_features.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _isUserLoggedIn();
  }

  Future<void> _isUserLoggedIn() async {
    final token = await sl<SecureStorageService>().read('token');

    if (mounted) {
      if (token != null) {
        sl<UserCubit>().getCurrentUserData();
        context.go(BottomNavigationBarWidget.routeName);
      } else {
        context.go(OnboardingScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: const Center(
        child: IconWidget(
          name: 'logo',
          height: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}

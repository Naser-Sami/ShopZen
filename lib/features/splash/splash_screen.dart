import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navToNextPage();
  }

  navToNextPage() async {
    await Future.delayed(Duration(seconds: 1)).then(
      (value) {
        if (mounted) {
          log("Current User: ${sl<FirebaseAuth>().currentUser}");
          if (sl<FirebaseAuth>().currentUser != null) {
            context.go(BottomNavigationBarWidget.routeName);
          } else {
            context.go(OnboardingScreen.routeName);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: IconWidget(
          name: 'logo',
          height: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}

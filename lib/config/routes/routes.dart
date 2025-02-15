import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  // Add your navigator observers
  observers: [
    AppNavigatorObserver(),
  ],
  navigatorKey: NavigationService.navigatorKey, // Set the navigatorKey
  errorBuilder: (context, state) => ErrorPage(
    state.error.toString(),
  ),
  redirect: (context, state) {
    return null;
  },
  routes: [
    GoRoute(
      path: SplashScreen.routeName,
      name: SplashScreen.routeName,
      pageBuilder: (context, state) => CupertinoPage(
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      path: OnboardingScreen.routeName,
      name: OnboardingScreen.routeName,
      pageBuilder: (context, state) => CupertinoPage(
        child: OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: LoginWithSocialScreen.routeName,
      name: LoginWithSocialScreen.routeName,
      pageBuilder: (context, state) => CupertinoPage(
        child: LoginWithSocialScreen(),
      ),
    ),
    GoRoute(
      path: LoginWithEmailScreen.routeName,
      name: LoginWithEmailScreen.routeName,
      pageBuilder: (context, state) => CupertinoPage(
        child: LoginWithEmailScreen(),
      ),
    ),
    GoRoute(
      path: SignUpWithSocialScreen.routeName,
      name: SignUpWithSocialScreen.routeName,
      pageBuilder: (context, state) => CupertinoPage(
        child: SignUpWithSocialScreen(),
      ),
    ),
    GoRoute(
      path: SignUpWithEmailScreen.routeName,
      name: SignUpWithEmailScreen.routeName,
      pageBuilder: (context, state) => CupertinoPage(
        child: SignUpWithEmailScreen(),
      ),
    ),
    GoRoute(
      path: BottomNavigationBarWidget.routeName,
      name: BottomNavigationBarWidget.routeName,
      pageBuilder: (context, state) => CupertinoPage(
        child: BottomNavigationBarWidget(),
      ),
    ),
    GoRoute(
      path: HomeScreen.routeName,
      name: HomeScreen.routeName,
      pageBuilder: (context, state) => CupertinoPage(
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: "${ProductDetailsScreen.routeName}/:index",
      name: "Products Details",
      pageBuilder: (context, state) {
        final product = state.extra as ProductEntity;

        return CupertinoPage(
          child: ProductDetailsScreen(product: product),
        );
      },
    ),
  ],
);

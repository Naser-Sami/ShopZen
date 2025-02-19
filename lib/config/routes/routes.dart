import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: SplashScreen.routeName,
  observers: [
    AppNavigatorObserver(),
  ],
  navigatorKey: NavigationService.navigatorKey,
  errorBuilder: (context, state) {
    if (state.uri.path.contains('/link')) {
      return BottomNavigationBarWidget();
    }

    return ErrorPage(
      state.error.toString(),
    );
  },
  redirect: (context, state) {
    if (state.uri.path.contains('/link')) {
      return BottomNavigationBarWidget.routeName;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: SplashScreen.routeName,
      name: 'Splash',
      pageBuilder: (context, state) => CupertinoPage(
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      path: OnboardingScreen.routeName,
      name: 'Onboarding',
      pageBuilder: (context, state) => CupertinoPage(
        child: OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: LoginWithSocialScreen.routeName,
      name: 'Login With Social',
      pageBuilder: (context, state) => slideFadeTransitionPage(
        context,
        state,
        LoginWithSocialScreen(),
      ),
    ),
    GoRoute(
      path: LoginWithEmailScreen.routeName,
      name: 'Login With Email',
      pageBuilder: (context, state) => CupertinoPage(
        child: LoginWithEmailScreen(),
      ),
    ),
    GoRoute(
      path: SignUpWithSocialScreen.routeName,
      name: 'Sign Up With Social',
      pageBuilder: (context, state) => CupertinoPage(
        child: SignUpWithSocialScreen(),
      ),
    ),
    GoRoute(
      path: SignUpWithEmailScreen.routeName,
      name: 'Sing Up With Email',
      pageBuilder: (context, state) => CupertinoPage(
        child: SignUpWithEmailScreen(),
      ),
    ),
    GoRoute(
      path: BottomNavigationBarWidget.routeName,
      name: '/',
      pageBuilder: (context, state) {
        return CupertinoPage(
          key: state.pageKey,
          child: BottomNavigationBarWidget(),
        );
      },
      routes: [
        GoRoute(
          path: HomeScreen.routeName,
          name: 'Home',
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
    ),
  ],
);

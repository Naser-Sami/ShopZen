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
  navigatorKey: navigatorKey,
  errorBuilder: (context, state) {
    if (state.uri.path.contains('/link')) {
      return HomeScreen();
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
      name: 'Sign Up With Email',
      pageBuilder: (context, state) => CupertinoPage(
        child: SignUpWithEmailScreen(),
      ),
    ),

    // Select Your Location Section
    GoRoute(
      path: AccessLocationScreen.routeName,
      name: 'Access Location',
      pageBuilder: (context, state) => CupertinoPage(
        child: AccessLocationScreen(),
      ),
    ),
    GoRoute(
      path: YourLocationScreen.routeName,
      name: 'Your Location',
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final lat = data['lat'] as double;
        final lng = data['lng'] as double;

        return CupertinoPage(
          child: YourLocationScreen(
            lat: lat,
            lng: lng,
          ),
        );
      },
    ),

    // StatefulShellRoute for BottomNavigationBarWidget
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavigationBarWidget(
          navigationShell: navigationShell,
        );
      },
      branches: [
        // Home Section
        StatefulShellBranch(
          navigatorKey: sectionNavigator,
          routes: [
            GoRoute(
              path: HomeScreen.routeName,
              name: 'Home',
              pageBuilder: (context, state) => CupertinoPage(
                child: HomeScreen(),
              ),
              routes: [
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
        ),

        // Saved Section
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SavedItemsScreen.routeName,
              name: 'Saved Items',
              pageBuilder: (context, state) => CupertinoPage(
                child: SavedItemsScreen(),
              ),
              routes: [],
            ),
          ],
        ),

        // Cart Section
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: CartScreen.routeName,
              name: 'Cart',
              pageBuilder: (context, state) => CupertinoPage(
                child: CartScreen(),
              ),
            ),
          ],
        ),

        // Users Section for chatting
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: UsersListScreen.routeName,
              name: 'Users List',
              pageBuilder: (context, state) => CupertinoPage(
                child: UsersListScreen(),
              ),
            ),
          ],
        ),

        // Account Section
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AccountScreen.routeName,
              name: 'Account',
              pageBuilder: (context, state) => CupertinoPage(
                child: AccountScreen(),
              ),
              routes: [
                GoRoute(
                  path: HelpCenterScreen.routeName,
                  name: 'Help Center',
                  pageBuilder: (context, state) => CupertinoPage(
                    child: HelpCenterScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // Move Customer Service to a Top-Level Route (Outside of StatefulShellRoute)
    GoRoute(
      path: "${CustomerServiceScreen.routeName}/:userName",
      name: 'Customer Service',
      parentNavigatorKey: navigatorKey, // Ensures no bottom nav
      pageBuilder: (context, state) {
        final user = state.extra as UserModel;

        return CupertinoPage(
          child: CustomerServiceScreen(user: user),
        );
      },
    ),

    // Chat Section
    GoRoute(
      path: "${ChatRoomScreen.routeName}/:userName",
      name: 'Chat',
      pageBuilder: (context, state) {
        final user = state.extra as UserModel;
        return CupertinoPage(
          child: ChatRoomScreen(
            user: user,
          ),
        );
      },
    ),

    // Notifications Settings Section
    GoRoute(
      path: NotificationsSettingsScreen.routeName,
      name: 'Notifications Settings',
      pageBuilder: (context, state) => CupertinoPage(
        child: NotificationsSettingsScreen(),
      ),
    ),

    // Notifications Screen Section
    GoRoute(
      path: NotificationsScreen.routeName,
      name: 'Notifications',
      pageBuilder: (context, state) => CupertinoPage(
        child: NotificationsScreen(),
      ),
    ),

    // Profile Section
    GoRoute(
      path: ProfileScreen.routeName,
      name: 'Profile',
      pageBuilder: (context, state) => CupertinoPage(
        child: ProfileScreen(),
      ),
    ),
  ],
);

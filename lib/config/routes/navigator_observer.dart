import 'package:flutter/material.dart';

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     log("""

// On Did Push Route

// route -> $route
// previousRoute -> $previousRoute

//         """);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     log("""

// On Did Pop Route

// route -> $route
// previousRoute -> $previousRoute

//         """);
  }
}

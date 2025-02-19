import 'package:flutter/widgets.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Create keys for `root` & `section` navigator avoiding unnecessary rebuilds
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _sectionNavigatorKey = GlobalKey<NavigatorState>();

  static get rootNavigator => _rootNavigatorKey.currentContext;
  static get sectionNavigator => _sectionNavigatorKey.currentContext;

  static BuildContext? get context => navigatorKey.currentContext;
}

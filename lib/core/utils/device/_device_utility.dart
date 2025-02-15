import 'dart:io';

// Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

// Files
import '/core/_core.dart';

class TDeviceUtils {
  TDeviceUtils._();

  static const layout4K = 2560;
  static const largeLayout = 1124;
  static const mediumLayout = 868;
  static const smallLayout = 650;

  static BuildContext context = NavigationService.navigatorKey.currentContext!;

  static final size = MediaQuery.of(context).size;

  static void hideKeyboard() => FocusScope.of(context).requestFocus(FocusNode());

  static Future<void> setStatusBarColor(Color color) async => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color),
      );

  static bool isLandscapeOrientation() => View.of(context).viewInsets.bottom == 0;

  static bool isPortraitOrientation() => View.of(context).viewInsets.bottom != 0;

  static void setFullScreen(bool enable) => SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
      );

  static double getScreenHeight() => MediaQuery.of(context).size.height;

  static double getScreenWidth() => MediaQuery.of(context).size.width;

  static double getPixelRatio() => MediaQuery.of(context).devicePixelRatio;

  static double getStatusBarHeight() => MediaQuery.of(context).padding.top;

  static double getBottomNavigationBarHeight() => kBottomNavigationBarHeight;

  static double getAppBarHeight() => kToolbarHeight;

  static double getKeyboardHeight() => View.of(context).viewInsets.bottom;

  static Future<bool> isKeyboardVisible() async => View.of(context).viewInsets.bottom > 0;

  static bool isPhysicalDevice() => defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;

  static bool isSmallLayout() => getScreenWidth() <= smallLayout;

  static bool isMediumLayout() => getScreenWidth() < largeLayout;

  static bool isSmallOrPhysicalDevice() => isPhysicalDevice() || isSmallLayout();

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  static Future<void> setPreferredOrientations(List<DeviceOrientation> orientations) async =>
      await SystemChrome.setPreferredOrientations(orientations);

  static void hideStatusBar() => SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );

  static void showStatusBar() => SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );

  static Future<bool> hasInternetConnection(String url) async {
    try {
      final result = await InternetAddress.lookup(url);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static bool isIOS() => Platform.isIOS;
  static bool isAndroid() => Platform.isAndroid;
  static bool isMacOS() => Platform.isMacOS;
  static bool isLinux() => Platform.isLinux;
  static bool isWindows() => Platform.isWindows;
  static bool isFuchsia() => Platform.isFuchsia;
  static int numberOfProcessors() => Platform.numberOfProcessors;

  static bool isDesktop() => (Platform.isMacOS || Platform.isLinux || Platform.isWindows);
}

import 'package:flutter/material.dart';

import '/core/_core.dart' show AppColorsExtension;
import '/config/_config.dart';
import '/core/utils/extensions/custom_box_decoration_theme_extension.dart';

/// ------------------------------
/// Custom Extensions -Light Theme
/// ------------------------------

Iterable<ThemeExtension<dynamic>>? lightExtensions = <ThemeExtension<dynamic>>[
  AppColorsExtension(
    skeleton: LightThemeColors.lightSkeleton,
  ),
  CustomBoxDecorationTheme(
    customBoxDecoration: const BoxDecoration(
      color: LightThemeColors.primaryContainer,
      borderRadius: BorderRadius.all(Radius.circular(TRadius.r08)),
    ),
    customBoxDecorationGradient: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(TRadius.r30)),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          for (int x = 0; x < 105; x += 5)
            LightThemeColors.primaryContainer.withValues(alpha: x / 100),
        ],
      ),
    ),
  ),
];

/// ------------------------------
/// Custom Extensions - Dark Theme
/// ------------------------------

Iterable<ThemeExtension<dynamic>>? darkExtensions = <ThemeExtension<dynamic>>[
  AppColorsExtension(
    skeleton: DarkThemeColors.darkSkeleton,
  ),
  CustomBoxDecorationTheme(
    customBoxDecoration: const BoxDecoration(
      color: DarkThemeColors.primaryContainer,
      borderRadius: BorderRadius.all(Radius.circular(TRadius.r08)),
    ),
    customBoxDecorationGradient: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(TRadius.r30)),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          for (int x = 0; x < 105; x += 5)
            DarkThemeColors.primaryContainer.withValues(alpha: x / 100),
        ],
      ),
    ),
  ),
];

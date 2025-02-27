import 'package:flutter/material.dart';

import '../../colors_guidance/dark_theme_colors.dart';

ColorScheme? _colorSchemeDark = const ColorScheme.dark(
  primary: DarkThemeColors.primary,
  onPrimary: DarkThemeColors.onPrimary,
  primaryContainer: DarkThemeColors.primaryContainer,
  onPrimaryContainer: DarkThemeColors.onPrimaryContainer,
  primaryFixed: DarkThemeColors.onPrimaryFixed,
  primaryFixedDim: DarkThemeColors.primaryFixedDim,
  onPrimaryFixedVariant: DarkThemeColors.onPrimaryFixedVariant,
  onError: DarkThemeColors.onError,
  errorContainer: DarkThemeColors.errorContainer,
  onErrorContainer: DarkThemeColors.onErrorContainer,

  surfaceContainerHighest: DarkThemeColors.surfaceVariant,

  // ----
  outline: DarkThemeColors.outline,
  outlineVariant: DarkThemeColors.outlineVariant,

  // --
  surface: DarkThemeColors.surface,
  onSurface: DarkThemeColors.onSurface,
  onSecondaryContainer: DarkThemeColors.onSurface,
  // --
  inverseSurface: DarkThemeColors.inverseSurface,
  onInverseSurface: DarkThemeColors.inverseOnSurface,

  shadow: DarkThemeColors.shadow,
  scrim: DarkThemeColors.scrim,
);

ColorScheme? get colorSchemeDark => _colorSchemeDark;

import 'package:flutter/material.dart';

import '../../colors_guidance/light_theme_colors.dart';

ColorScheme? _colorSchemeLight = const ColorScheme.light(
  onSurface: LightThemeColors.onSurface,

  primary: LightThemeColors.primary,
  primaryContainer: LightThemeColors.primaryContainer,
  onPrimaryContainer: LightThemeColors.onPrimaryContainer,
  primaryFixed: LightThemeColors.onPrimaryFixed,
  primaryFixedDim: LightThemeColors.primaryFixedDim,
  onPrimaryFixedVariant: LightThemeColors.onPrimaryFixedVariant,

  // ---
  error: LightThemeColors.error,
  errorContainer: LightThemeColors.errorContainer,
  onErrorContainer: LightThemeColors.onErrorContainer,

  surfaceContainerHighest: LightThemeColors.surfaceVariant,

  // ----
  outline: LightThemeColors.outline,
  outlineVariant: LightThemeColors.outlineVariant,

  // --
  surface: LightThemeColors.surface,
  onSecondaryContainer: LightThemeColors.onSurface,

  // // --
  inverseSurface: LightThemeColors.inverseSurface,
  onInverseSurface: LightThemeColors.inverseOnSurface,

  shadow: LightThemeColors.shadow,
  scrim: LightThemeColors.scrim,
);

ColorScheme? get colorSchemeLight => _colorSchemeLight;

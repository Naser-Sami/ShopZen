import 'package:flutter/material.dart';

import '/config/theme/_theme.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TTextStyle.displayLarge().apply(
      color: LightThemeColors.onBackground,
    ),
    displayMedium: TTextStyle.displayMedium().apply(
      color: LightThemeColors.onBackground,
    ),
    displaySmall: TTextStyle.displaySmall().apply(
      color: LightThemeColors.onBackground,
    ),
    headlineLarge: TTextStyle.headlineLarge().apply(
      color: LightThemeColors.onBackground,
    ),
    headlineMedium: TTextStyle.headlineMedium().apply(
      color: LightThemeColors.onBackground,
    ),
    headlineSmall: TTextStyle.headlineSmall().apply(
      color: LightThemeColors.onBackground,
    ),
    titleLarge: TTextStyle.titleLarge().apply(
      color: LightThemeColors.onBackground,
    ),
    titleMedium: TTextStyle.titleMedium().apply(
      color: LightThemeColors.onBackground,
    ),
    titleSmall: TTextStyle.titleSmall().apply(
      color: LightThemeColors.onBackground,
    ),
    bodyLarge: TTextStyle.bodyLarge().apply(
      color: LightThemeColors.onBackground,
    ),
    bodyMedium: TTextStyle.bodyMedium().apply(
      color: LightThemeColors.onBackground.withValues(alpha: 0.60),
    ),
    bodySmall: TTextStyle.bodySmall().apply(
      color: LightThemeColors.onBackground.withValues(alpha: 0.60),
    ),
    labelLarge: TTextStyle.labelLarge().apply(
      color: LightThemeColors.onBackground.withValues(alpha: 0.60),
    ),
    labelMedium: TTextStyle.labelMedium().apply(
      color: LightThemeColors.onBackground.withValues(alpha: 0.60),
    ),
    labelSmall: TTextStyle.labelSmall().apply(
      color: LightThemeColors.onBackground.withValues(alpha: 0.60),
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TTextStyle.displayLarge().apply(
      color: DarkThemeColors.onBackground,
    ),
    displayMedium: TTextStyle.displayMedium().apply(
      color: DarkThemeColors.onBackground,
    ),
    displaySmall: TTextStyle.displaySmall().apply(
      color: DarkThemeColors.onBackground,
    ),
    headlineLarge: TTextStyle.headlineLarge().apply(
      color: DarkThemeColors.onBackground,
    ),
    headlineMedium: TTextStyle.headlineMedium().apply(
      color: DarkThemeColors.onBackground,
    ),
    headlineSmall: TTextStyle.headlineSmall().apply(
      color: DarkThemeColors.onBackground,
    ),
    titleLarge: TTextStyle.titleLarge().apply(
      color: DarkThemeColors.onBackground,
    ),
    titleMedium: TTextStyle.titleMedium().apply(
      color: DarkThemeColors.onBackground,
    ),
    titleSmall: TTextStyle.titleSmall().apply(
      color: DarkThemeColors.onBackground,
    ),
    bodyLarge: TTextStyle.bodyLarge().apply(
      color: DarkThemeColors.onBackground,
    ),
    bodyMedium: TTextStyle.bodyMedium().apply(
      color: DarkThemeColors.onBackground.withValues(alpha: 0.60),
    ),
    bodySmall: TTextStyle.bodySmall().apply(
      color: DarkThemeColors.onBackground.withValues(alpha: 0.60),
    ),
    labelLarge: TTextStyle.labelLarge().apply(
      color: DarkThemeColors.onBackground.withValues(alpha: 0.60),
    ),
    labelMedium: TTextStyle.labelMedium().apply(
      color: DarkThemeColors.onBackground.withValues(alpha: 0.60),
    ),
    labelSmall: TTextStyle.labelSmall().apply(
      color: DarkThemeColors.onBackground.withValues(alpha: 0.60),
    ),
  );
}

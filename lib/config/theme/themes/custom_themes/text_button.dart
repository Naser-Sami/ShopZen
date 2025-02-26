import 'package:flutter/material.dart';
import '/config/_config.dart';

final darkTextButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    elevation: 0,
    overlayColor: DarkThemeColors.onPrimary,
    foregroundColor: DarkThemeColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TRadius.r08),
    ),
    textStyle: TTextStyle.titleMedium().apply(
      color: DarkThemeColors.onBackground,
    ),
  ),
);

final lightTextButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    elevation: 0,
    overlayColor: LightThemeColors.onPrimary,
    foregroundColor: LightThemeColors.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(TRadius.r08),
    ),
    textStyle: TTextStyle.titleMedium().apply(
      color: LightThemeColors.onBackground,
    ),
  ),
);

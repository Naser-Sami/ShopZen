import 'package:flutter/material.dart';
import '/config/_config.dart';

final elevatedButtonThemeDark = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
  elevation: 0,
  fixedSize: Size(double.maxFinite, TSize.s50),
  backgroundColor: DarkThemeColors.primary,
  foregroundColor: DarkThemeColors.onPrimary,
  disabledBackgroundColor: DarkThemeColors.primaryFixedDim,
  disabledForegroundColor: DarkThemeColors.onPrimary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(TRadius.r08),
  ),
  textStyle: TTextStyle.titleMedium().apply(
    color: DarkThemeColors.onBackground,
  ),
));

final elevatedButtonThemeLight = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
  elevation: 0,
  fixedSize: Size(double.maxFinite, TSize.s50),
  backgroundColor: LightThemeColors.primary,
  foregroundColor: LightThemeColors.onPrimary,
  disabledBackgroundColor: LightThemeColors.primaryFixedDim,
  disabledForegroundColor: LightThemeColors.onPrimary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(TRadius.r08),
  ),
  textStyle: TTextStyle.titleMedium().apply(
    color: LightThemeColors.onBackground,
  ),
));

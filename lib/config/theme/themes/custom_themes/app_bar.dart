import 'package:flutter/material.dart';
import '/config/_config.dart';

final appBarThemeDark = AppBarTheme(
  backgroundColor: DarkThemeColors.background,
  foregroundColor: DarkThemeColors.onSurface,
  elevation: 0,
  scrolledUnderElevation: 0.0,
  centerTitle: true,
  titleTextStyle: TTextTheme.darkTextTheme.titleLarge,
  toolbarTextStyle: TTextTheme.darkTextTheme.titleLarge,
  iconTheme: const IconThemeData(color: DarkThemeColors.onSurface),
  actionsIconTheme: const IconThemeData(color: DarkThemeColors.onSurface),
);

final appBarThemeLight = AppBarTheme(
  backgroundColor: LightThemeColors.background,
  foregroundColor: LightThemeColors.onSurface,
  elevation: 0,
  scrolledUnderElevation: 0.0,
  centerTitle: true,
  titleTextStyle: TTextTheme.lightTextTheme.titleLarge,
  toolbarTextStyle: TTextTheme.lightTextTheme.titleLarge,
  iconTheme: const IconThemeData(color: LightThemeColors.onSurface),
  actionsIconTheme: const IconThemeData(color: LightThemeColors.onSurface),
);

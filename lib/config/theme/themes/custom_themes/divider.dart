import 'package:flutter/material.dart';

import '/config/_config.dart';

DividerThemeData? lightDividerTheme = DividerThemeData(
  space: 0,
  thickness: 1.2,
  color: LightThemeColors.onBackground.withValues(alpha: 0.25),
);

DividerThemeData? darkDividerTheme = DividerThemeData(
  space: 0,
  thickness: 1.2,
  color: DarkThemeColors.onBackground.withValues(alpha: 0.25),
);

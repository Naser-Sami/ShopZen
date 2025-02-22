import 'package:flutter/material.dart';
import '/config/_config.dart';

final bottomSheetThemeDark = BottomSheetThemeData(
  backgroundColor: DarkThemeColors.secondaryContainer,
  modalBackgroundColor: DarkThemeColors.secondaryContainer,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(16.0),
    ),
  ),
);

final bottomSheetThemeLight = BottomSheetThemeData(
  backgroundColor: LightThemeColors.background,
  modalBackgroundColor: LightThemeColors.background,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(16.0),
    ),
  ),
);

// Access the custom extension from the theme
import 'package:flutter/material.dart';
import '/core/_core.dart';

customBoxDecorationTheme(BuildContext context) => Theme.of(context).extension<CustomBoxDecorationTheme>()?.customBoxDecoration;
customBoxDecorationThemeGradient(BuildContext context) => Theme.of(context).extension<CustomBoxDecorationTheme>()?.customBoxDecorationGradient;

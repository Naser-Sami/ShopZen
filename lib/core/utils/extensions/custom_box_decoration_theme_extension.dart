import 'package:flutter/material.dart';

class CustomBoxDecorationTheme extends ThemeExtension<CustomBoxDecorationTheme> {
  final BoxDecoration customBoxDecoration;
  final BoxDecoration customBoxDecorationGradient;

  CustomBoxDecorationTheme({required this.customBoxDecoration, required this.customBoxDecorationGradient});

  @override
  CustomBoxDecorationTheme copyWith({BoxDecoration? customBoxDecoration, BoxDecoration? customBoxDecorationGradient}) {
    return CustomBoxDecorationTheme(
      customBoxDecoration: customBoxDecoration ?? this.customBoxDecoration,
      customBoxDecorationGradient: customBoxDecorationGradient ?? this.customBoxDecorationGradient,
    );
  }

  @override
  CustomBoxDecorationTheme lerp(ThemeExtension<CustomBoxDecorationTheme>? other, double t) {
    if (other is! CustomBoxDecorationTheme) return this;
    return CustomBoxDecorationTheme(
      customBoxDecoration: BoxDecoration.lerp(customBoxDecoration, other.customBoxDecoration, t)!,
      customBoxDecorationGradient: BoxDecoration.lerp(customBoxDecorationGradient, other.customBoxDecorationGradient, t)!,
    );
  }
}

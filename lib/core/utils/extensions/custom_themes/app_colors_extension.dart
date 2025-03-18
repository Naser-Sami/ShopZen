import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  AppColorsExtension({
    required this.skeleton,
  });

  final Color skeleton;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? skeleton,
  }) {
    return AppColorsExtension(
      skeleton: skeleton ?? this.skeleton,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
      covariant ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      skeleton: Color.lerp(skeleton, other.skeleton, t)!,
    );
  }
}

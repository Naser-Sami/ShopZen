import 'package:flutter/material.dart';
import '_typography.dart';

class TTextStyle {
  TTextStyle._();

  static TextStyle displayLarge() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.displayLarge,
        fontWeight: FontWeight.w900,
      );

  static TextStyle displayMedium() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.displayMedium,
        fontWeight: FontWeight.w800,
      );

  static TextStyle displaySmall() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.displaySmall,
        fontWeight: FontWeight.w700,
      );

  static TextStyle headlineLarge() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.headlineLarge,
        fontWeight: FontWeight.w600,
      );

  static TextStyle headlineMedium() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.headlineMedium,
        fontWeight: FontWeight.w500,
      );

  static TextStyle headlineSmall() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.headlineSmall,
        fontWeight: FontWeight.w400,
      );

  static TextStyle titleLarge() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.titleLarge,
        fontWeight: FontWeight.w600,
      );

  static TextStyle titleMedium() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.titleMedium,
        fontWeight: FontWeight.w500,
      );

  static TextStyle titleSmall() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.titleSmall,
        fontWeight: FontWeight.w400,
      );

  static TextStyle labelLarge() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.labelLarge,
        fontWeight: FontWeight.w400,
      );

  static TextStyle labelMedium() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.labelMedium,
        fontWeight: FontWeight.w400,
      );

  static TextStyle labelSmall() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.labelSmall,
        fontWeight: FontWeight.w400,
      );

  static TextStyle bodyLarge() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.bodyLarge,
        fontWeight: FontWeight.w400,
      );

  static TextStyle bodyMedium() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.bodyMedium,
        fontWeight: FontWeight.w400,
      );

  static TextStyle bodySmall() => const TextStyle().copyWith(
        fontSize: SystemFontsStyle.bodySmall,
        fontWeight: FontWeight.w400,
      );
}

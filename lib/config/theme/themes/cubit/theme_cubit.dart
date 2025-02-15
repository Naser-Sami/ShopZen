import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme(); // Load theme on initialization
  }

  ThemeStyle? initialValue = ThemeStyle.system;

  Future<void> switchTheme(ThemeStyle t) async {
    final box = Hive.box('settings');

    switch (t) {
      case ThemeStyle.system:
        initialValue = ThemeStyle.system;
        await box.put('theme', 'system');
        emit(ThemeMode.system);
        break;
      case ThemeStyle.light:
        initialValue = ThemeStyle.light;
        await box.put('theme', 'light');
        emit(ThemeMode.light);
        break;
      case ThemeStyle.dark:
        initialValue = ThemeStyle.dark;
        await box.put('theme', 'dark');
        emit(ThemeMode.dark);
        break;
    }
  }

  void _loadTheme() {
    final box = Hive.box('settings');
    String? theme = box.get('theme', defaultValue: 'system');

    switch (theme) {
      case 'light':
        emit(ThemeMode.light);
        break;
      case 'dark':
        emit(ThemeMode.dark);
        break;
      default:
        emit(ThemeMode.system);
        break;
    }
  }
}

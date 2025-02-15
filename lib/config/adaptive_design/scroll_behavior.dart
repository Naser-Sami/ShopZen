// Packages
import 'dart:ui';
import 'package:flutter/material.dart';

ScrollBehavior? scrollBehavior = const MaterialScrollBehavior().copyWith(
  dragDevices: {
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
    PointerDeviceKind.unknown,
  },
);

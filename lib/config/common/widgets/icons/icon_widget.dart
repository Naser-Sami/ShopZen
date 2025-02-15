import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.name,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.extension = 'svg',
    this.folder = 'icons',
  });

  final String name;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final String extension;
  final String? folder;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/$folder/$name.$extension',
      width: width ?? 24,
      height: height ?? 24,
      colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      fit: fit,
    );
  }
}

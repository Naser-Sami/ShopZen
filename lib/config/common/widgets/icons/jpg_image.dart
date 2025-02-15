import 'package:flutter/material.dart';

class JpgImageWidget extends StatelessWidget {
  const JpgImageWidget({
    super.key,
    required this.name,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String name;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$name.jpg',
      width: width ?? 24,
      height: height ?? 24,
      fit: fit,
    );
  }
}

DecorationImage? jpgImage({required String name, BoxFit? fit}) => DecorationImage(
      image: AssetImage(
        'assets/images/$name.jpg',
      ),
      fit: fit,
    );

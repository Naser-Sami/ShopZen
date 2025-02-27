import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final bool withBorder;
  final double? radius;
  final String imageUrl;

  const CircleImageWidget({
    super.key,
    this.withBorder = false,
    this.radius,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (withBorder) {
      return Container(
        width: radius ?? 60,
        height: radius ?? 60,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.4,
          ),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              imageUrl,
            ),
          ),
        ),
      );
    }

    return Container(
      width: radius ?? 60,
      height: radius ?? 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl,
        ),
      ),
    );
  }
}

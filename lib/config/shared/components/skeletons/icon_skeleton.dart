import 'package:flutter/material.dart';
import '/core/_core.dart';

class IconSkeleton extends StatelessWidget {
  const IconSkeleton({
    required this.dimension,
    required this.radius,
    super.key,
  });

  final double dimension;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.skeleton,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
      ),
    );
  }
}

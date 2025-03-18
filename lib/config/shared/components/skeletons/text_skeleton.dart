import 'dart:math' as math;

import 'package:flutter/material.dart';
import '/core/_core.dart';

class TextSkeleton extends StatelessWidget {
  const TextSkeleton({
    required this.textStyle,
    required this.widthFactor,
    required this.radius,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  final TextStyle textStyle;
  final double widthFactor;
  final double radius;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final textScaler = MediaQuery.textScalerOf(context);

    final fontSize = textScaler.scale(
      textStyle.fontSize ?? defaultTextStyle.style.fontSize ?? 18,
    );
    final fontHeight = math.max(
      textStyle.height ?? defaultTextStyle.style.height ?? 1,
      1,
    );

    final height = fontSize * fontHeight;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: (height - fontSize) / 2),
      child: SizedBox(
        height: fontSize,
        child: FractionallySizedBox(
          alignment: alignment,
          widthFactor: widthFactor,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.skeleton,
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),
          ),
        ),
      ),
    );
  }
}

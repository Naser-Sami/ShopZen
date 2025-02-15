import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '/core/_core.dart';

class NeumorphismContainer extends StatelessWidget {
  const NeumorphismContainer(
      {super.key,
      this.child,
      this.inset = true,
      this.shape = BoxShape.rectangle,
      this.borderRadius,
      this.userDefaultMargin = false,
      this.surfaceColor,
      this.blurRadius = 10,
      this.offset = const Offset(5, 5)});

  final Widget? child;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  final bool inset, userDefaultMargin;
  final Color? surfaceColor;
  final double blurRadius;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    TDeviceUtils.context = context;

    EdgeInsetsGeometry? margin() {
      if (!userDefaultMargin) return null;

      if (TDeviceUtils.isSmallOrPhysicalDevice()) {
        return const EdgeInsets.all(24);
      } else {
        return const EdgeInsets.all(48);
      }
    }

    return Container(
      margin: margin(),
      decoration: BoxDecoration(
        color: surfaceColor ?? Theme.of(context).colorScheme.surface,
        borderRadius:
            (shape == BoxShape.rectangle) ? borderRadius ?? BorderRadius.circular(30) : null,
        shape: shape,
        boxShadow: [
          // Right and Bottom
          BoxShadow(
            blurRadius: blurRadius,
            offset: -offset,
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.25),
            inset: inset,
          ),
          // Left and Top
          BoxShadow(
            blurRadius: blurRadius,
            offset: offset,
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.50),
            inset: inset,
          ),
        ],
      ),
      child: child,
    );
  }
}

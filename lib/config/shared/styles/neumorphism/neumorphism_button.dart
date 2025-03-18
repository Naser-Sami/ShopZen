import 'package:flutter/material.dart';

import '/config/_config.dart';

class NeumorphismButton extends StatelessWidget {
  const NeumorphismButton(
      {super.key,
      this.onTap,
      this.onHover,
      required this.isHovered,
      required this.text,
      this.surfaceColor,
      this.blurRadius = 10,
      this.textStyle,
      this.width,
      this.height,
      this.offset = const Offset(5, 5)});

  final void Function()? onTap;
  final void Function(bool)? onHover;
  final bool isHovered;
  final String text;
  final Color? surfaceColor;
  final double blurRadius;
  final Offset offset;
  final TextStyle? textStyle;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onHover: (bool val) => onHover!(val),
      child: AnimatedContainer(
        width: width ?? 150,
        height: height,
        duration: const Duration(milliseconds: 100),
        child: NeumorphismContainer(
          inset: isHovered,
          surfaceColor: surfaceColor,
          blurRadius: blurRadius,
          offset: offset,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Center(
              child: TextWidget(
                text,
                textAlign: TextAlign.center,
                style: textStyle ??
                    TextStyle(
                      fontWeight: isHovered ? FontWeight.bold : null,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

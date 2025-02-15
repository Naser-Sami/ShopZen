import 'package:flutter/material.dart';

class PopupMenuButtonComponent<T> extends StatelessWidget {
  final T? initialValue;
  final ValueChanged<T>? onSelected;
  final List<PopupMenuEntry<T>> Function(BuildContext) itemBuilder;
  final AnimationStyle? popUpAnimationStyle;

  const PopupMenuButtonComponent({
    super.key,
    this.initialValue,
    this.onSelected,
    this.popUpAnimationStyle,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      initialValue: initialValue,
      onSelected: onSelected,
      popUpAnimationStyle: popUpAnimationStyle,
      icon: const Icon(Icons.more_vert),
      itemBuilder: itemBuilder,
    );
  }
}

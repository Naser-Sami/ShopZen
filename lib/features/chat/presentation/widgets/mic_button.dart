import 'package:flutter/material.dart';

import '/config/_config.dart';

class MicButton extends StatelessWidget {
  const MicButton({super.key, required this.icon, this.onPressed});

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MaterialButton(
      onPressed: onPressed,
      minWidth: TSize.s56,
      height: TSize.s56,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSize.s12),
      ),
      child: Container(
        width: TSize.s56,
        height: TSize.s56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSize.s12),
          color: colorScheme.primary,
        ),
        child: Icon(
          icon,
          size: 33,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}

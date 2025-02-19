import 'package:flutter/material.dart';

import '/config/_config.dart';

class CustomerServiceMicButton extends StatelessWidget {
  const CustomerServiceMicButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MaterialButton(
      onPressed: () {},
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
          Icons.mic_none_outlined,
          size: 33,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}

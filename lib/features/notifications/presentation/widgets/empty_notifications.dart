import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.all(TPadding.p42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IconWidget(
              name: 'notification-big',
              width: TSize.s64,
              height: TSize.s64,
            ),
            TSize.s16.toHeight,
            TextWidget(
              "You haven't gotten any notifications yet!",
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            TSize.s12.toHeight,
            TextWidget(
              "We'll alert you when something cool happens.",
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

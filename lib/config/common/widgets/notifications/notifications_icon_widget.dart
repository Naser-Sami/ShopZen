import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () {
        // only for test sing out
        sl<IFirebaseAuthService>().signOut().then((value) {
          if (context.mounted) {
            context.go(OnboardingScreen.routeName);
          }
        });
      },
      icon: IconWidget(
        name: 'notification',
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

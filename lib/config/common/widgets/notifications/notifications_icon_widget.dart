import 'package:flutter/material.dart';

import '/config/_config.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () {},
      icon: IconWidget(
        name: 'notification',
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

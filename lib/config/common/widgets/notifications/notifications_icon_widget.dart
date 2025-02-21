import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () async {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        sl<INotificationsService>().sendNotification(
          fcmToken: fcmToken ?? '',
          title: "Test Notification",
          body: "This is a test notification",
          data: {},
        );
      },
      icon: IconWidget(
        name: 'notification',
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

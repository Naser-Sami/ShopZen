import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      // onPressed: () => context.push(NotificationsScreen.routeName),
      onPressed: () async {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        await sl<INotificationsService>().sendNotification(
          fcmToken: fcmToken ?? '',
          title: "Test Notification",
          body: "This is a test notification",
          data: {
            "userId": "o9RL7kIghgd6aDFEALfqP1KyudZ2",
            "name": "Naser Sami Ebedo",
            "notificationType": NotificationsType.newMessage.name,
            "user": jsonEncode(
                sl<UserCubit>().state!.toMap()) // encode the map to a JSON string
          },
        );
      },
      icon: IconWidget(
        name: 'notification',
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

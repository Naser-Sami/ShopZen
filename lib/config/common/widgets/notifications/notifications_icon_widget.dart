import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

import '/config/_config.dart';
import '/features/_features.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () => context.push(NotificationsScreen.routeName),
      // onPressed: () async {
      //   // createNotificationCollection(sl<UserCubit>().state!.uid);

      //   final fcmToken = await FirebaseMessaging.instance.getToken();
      //   await sl<INotificationsService>().sendNotification(
      //     fcmToken: fcmToken ?? '',
      //     title: "Test Notification",
      //     body: "This is a test notification",
      //     data: {
      //       "userId": "o9RL7kIghgd6aDFEALfqP1KyudZ2",
      //       "name": "Naser Sami Ebedo",
      //       "notificationType": NotificationsType.newMessage.name,
      //       "user": jsonEncode(
      //           sl<UserCubit>().state!.toMap()) // encode the map to a JSON string
      //     },
      //   );
      // },
      icon: badges.Badge(
        showBadge: true,
        position: badges.BadgePosition.topEnd(top: -14, end: -8),
        badgeContent: StreamBuilder<List<NotificationsModel>>(
          stream: NotificationsController.getNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            if (snapshot.hasError) {
              return const SizedBox();
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const SizedBox();
            }
            return Text(
              snapshot.data!.length.toString(),
              style: theme.textTheme.bodyMedium,
            );
          },
        ),
        badgeStyle: badges.BadgeStyle(
          badgeColor: theme.colorScheme.primaryContainer,
          shape: badges.BadgeShape.circle,
        ),
        child: IconWidget(
          name: 'notification',
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

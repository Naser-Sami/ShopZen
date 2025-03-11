import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

import '/config/_config.dart';
import '/features/_features.dart';

class NotificationsIconWidget extends StatefulWidget {
  const NotificationsIconWidget({super.key});

  @override
  State<NotificationsIconWidget> createState() => _NotificationsIconWidgetState();
}

class _NotificationsIconWidgetState extends State<NotificationsIconWidget> {
  final showBadge = false;

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

            final notificationsCount =
                snapshot.data?.where((e) => !e.isRead).length.toString();

            if (notificationsCount == '0') {
              return const SizedBox();
            }

            return Text(
              notificationsCount ?? '0',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
        badgeStyle: badges.BadgeStyle(
          badgeColor: theme.colorScheme.onSurface,
        ),
        child: IconWidget(
          name: 'notification',
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

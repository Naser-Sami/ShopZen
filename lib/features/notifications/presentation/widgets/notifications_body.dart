import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class NotificationsBody extends StatefulWidget {
  const NotificationsBody({super.key, required this.notifications});

  final List<NotificationsModel> notifications;

  @override
  State<NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<NotificationsBody> {
  Future<void> _onDismissed(DismissDirection direction, String notificationId) async {
    await NotificationsController.deleteNotification(notificationId);

    widget.notifications.removeWhere((n) => n.id == notificationId);
  }

  Future<void> _onNotificationTap(NotificationsModel notification) async {
    if (notification.type == NotificationsType.newMessage.name) {
      final userSnapshot = sl<FirebaseFirestore>().collection('users').snapshots();
      final userStream = userSnapshot.map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data(), doc.id)).toList());

      // get user data from firestore
      userStream.listen(
        (users) {
          final user = users.firstWhere(
              // check on email or id
              (user) => user.uid == notification.senderId);
          if (mounted) {
            context.push(
              "${ChatRoomScreen.routeName}/${notification.title}",
              extra: user,
            );
          }
        },
      );
    }

    await NotificationsController.markNotificationAsRead(notification.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.notifications.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final notification = widget.notifications[index];

        final DateTime dateTime = notification.createdAt;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isFirstFromDate(widget.notifications, index, dateTime))
              _buildTimestamp(context, dateTime),
            Dismissible(
              key: Key(notification.id),
              onDismissed: (DismissDirection direction) async =>
                  await _onDismissed(direction, notification.id),
              background: _swipeToDelete(),
              child: ListTile(
                onTap: () => _onNotificationTap(notification),
                leading: Icon(notification.isRead
                    ? Icons.notifications_none
                    : Icons.notifications_active),
                title: Text(
                  notification.title,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  notification.body,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget? _swipeToDelete() => const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_outline,
            color: Colors.grey,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Delete Notification",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      );

  /// **Check if the current message is the first message of a new date**
  bool _isFirstFromDate(
      List<NotificationsModel> notification, int index, DateTime dateTime) {
    if (index == 0) return true; // The first message always gets a date header

    final previousMessageTimestamp = notification[index - 1].createdAt;
    final DateTime previousDate = previousMessageTimestamp;

    return previousDate.day != dateTime.day;
  }

  /// **Timestamp for the last message of the sender**
  Widget _buildTimestamp(BuildContext context, DateTime dateTime) {
    return Column(
      children: [
        const SizedBox(height: TSize.s08),
        Text(
          dateTime.timeAgo(),
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: TSize.s16),
      ],
    );
  }
}

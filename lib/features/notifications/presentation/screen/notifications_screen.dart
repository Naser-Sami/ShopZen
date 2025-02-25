import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/features/_features.dart';
import '/config/_config.dart';
import '/core/_core.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final firestoreService = sl<IFirestoreService<NotificationsModel>>();

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final textTheme = theme.textTheme;
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: StreamBuilder<List<NotificationsModel>>(
              stream: NotificationsController.getNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return emptyNotifications(context);
                }

                final notifications = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];

                    return Dismissible(
                      key: Key(notification.id),
                      direction: DismissDirection.horizontal,
                      onDismissed: (DismissDirection direction) async {
                        if (direction == DismissDirection.endToStart) {
                          await NotificationsController.deleteNotification(
                              notification.id);
                        }
                      },
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
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
                      ),
                      child: ListTile(
                        onTap: () async {
                          if (notification.type == NotificationsType.newMessage.name) {
                            final userSnapshot =
                                sl<FirebaseFirestore>().collection('users').snapshots();
                            final userStream = userSnapshot.map((snapshot) => snapshot
                                .docs
                                .map((doc) => UserModel.fromJson(doc.data(), doc.id))
                                .toList());

                            // get user data from firestore
                            userStream.listen(
                              (users) {
                                final user = users.firstWhere(
                                    // check on email or id
                                    (user) => user.uid == notification.senderId);
                                if (context.mounted) {
                                  context.push(
                                    "${ChatRoomScreen.routeName}/${notification.title}",
                                    extra: user,
                                  );
                                }
                              },
                            );
                          }

                          await NotificationsController.markNotificationAsRead(
                              notification.id);
                        },
                        leading: Icon(notification.isRead
                            ? Icons.notifications_none
                            : Icons.notifications_active),
                        title: Text(
                          notification.title,
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight:
                                notification.isRead ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          notification.body,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight:
                                notification.isRead ? FontWeight.normal : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }

  Widget emptyNotifications(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconWidget(
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
            ),
          ],
        ),
      ),
    );
  }
}

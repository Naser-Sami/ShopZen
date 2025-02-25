import 'package:flutter/material.dart';

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
                return const EmptyNotifications();
              }

              final notifications = snapshot.data!;

              return NotificationsBody(notifications: notifications);
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/core/_core.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(TPadding.p20),
          child: ListView(
            children: [
              Dismissible(
                key: Key('notification-id-1'),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {},
                // dismissThresholds: const {
                //   DismissDirection.endToStart: 0.25,
                //   DismissDirection.startToEnd: 0.25,
                // },
                confirmDismiss: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    return Future.delayed(
                      const Duration(milliseconds: 100),
                      () => true,
                    );
                  } else {
                    return Future.delayed(
                      const Duration(milliseconds: 100),
                      () => false,
                    );
                  }
                },
                background: Container(
                  color: Colors.green,
                ),
                secondaryBackground: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                  onTap: () {},
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notification 1'),
                  subtitle: Text(
                    'This is the first notification',
                    style: context.textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
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

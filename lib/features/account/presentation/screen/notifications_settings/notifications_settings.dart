import 'package:flutter/material.dart';

import '/config/_config.dart';

class NotificationsSettingsModel {
  final String title;
  final bool active;

  // copy with value
  NotificationsSettingsModel copyWith({
    String? title,
    bool? active,
  }) =>
      NotificationsSettingsModel(
        title: title ?? this.title,
        active: active ?? this.active,
      );

  NotificationsSettingsModel({required this.title, required this.active});
}

class NotificationsSettingsScreen extends StatefulWidget {
  static const routeName = '/notifications-settings';
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  List<NotificationsSettingsModel> data = [
    NotificationsSettingsModel(
      title: 'General Notifications',
      active: true,
    ),
    NotificationsSettingsModel(
      title: 'Sound',
      active: true,
    ),
    NotificationsSettingsModel(
      title: 'Vibrate',
      active: false,
    ),
    NotificationsSettingsModel(
      title: 'Special Offers',
      active: true,
    ),
    NotificationsSettingsModel(
      title: 'Promo & Discounts',
      active: true,
    ),
    NotificationsSettingsModel(
      title: 'Payments',
      active: false,
    ),
    NotificationsSettingsModel(
      title: 'Cashback',
      active: false,
    ),
    NotificationsSettingsModel(
      title: 'App Updates',
      active: true,
    ),
    NotificationsSettingsModel(
      title: 'New Services Available',
      active: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          NotificationsIconWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: ListView(
          children: [
            SizedBox(height: TSize.s24),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: TSize.s08,
                child: Divider(),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  minTileHeight: TSize.s64,
                  title: TextWidget(data[index].title),
                  trailing: Switch(
                    value: data[index].active,
                    activeColor: colorScheme.onSurface,
                    onChanged: (value) {
                      setState(
                        () {
                          var newData = data[index].copyWith(active: value);
                          data[index] = newData;
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

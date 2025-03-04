import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account';
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final repo = sl<IAccountRepository>();
  List<AccountFieldsEntity> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    data = repo.getAccountFields();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Account'),
        actions: const [
          NotificationsIconWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TPadding.p20),
        child: ListView(
          children: [
            TSize.s24.toHeight,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(height: 8),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    switch (data[index].name) {
                      case 'Your Profile':
                        context.push(ProfileScreen.routeName);
                        break;

                      case 'Help Center':
                        context.push(
                            "${AccountScreen.routeName}/${HelpCenterScreen.routeName}");
                        break;

                      case 'Notifications':
                        context.push(NotificationsSettingsScreen.routeName);
                        break;

                      case 'My Orders':
                        context.push(MyOrdersScreen.routeName);
                        break;
                      default:
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  minTileHeight: TSize.s64,
                  leading: IconWidget(
                    name: data[index].icon,
                    color: colorScheme.onSurface,
                  ),
                  title: TextWidget(data[index].name),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                  ),
                );
              },
            ),
            const Divider(height: 8),
            TSize.s48.toHeight,
            ListTile(
              onTap: logout,
              minTileHeight: TSize.s64,
              leading: const IconWidget(name: 'logout'),
              title: TextWidget(
                'Log Out',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logout() {
    logoutBottomSheet(context);
  }
}

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
        actions: [
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => const Divider(height: 8),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    switch (data[index].name) {
                      case 'Help Center':
                        context.push(
                            "${AccountScreen.routeName}/${HelpCenterScreen.routeName}");
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
                  trailing: Icon(
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
              leading: IconWidget(name: 'logout'),
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.40,
          widthFactor: 1,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  TSize.s40.toHeight,
                  TextWidget('Logout', style: textTheme.headlineMedium),
                  TSize.s24.toHeight,
                  Divider(),
                  TSize.s24.toHeight,
                  TextWidget(
                    "Are you sure you want to log out?",
                    style: textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TFunctions.isDarkMode(context)
                                ? Colors.grey
                                : Colors.grey.shade300,
                          ),
                          child: TextWidget(
                            'Cancel',
                            style: textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      TSize.s16.toWidth,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // only for test sing out
                            sl<IFirebaseAuthService>().signOut().then((value) {
                              if (context.mounted) {
                                context.go(OnboardingScreen.routeName);
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                          ),
                          child: TextWidget(
                            'Yes, Logout',
                            style: textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TSize.s24.toHeight,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class HelpCenterScreen extends StatefulWidget {
  static const routeName = 'help-center';
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<HelpCenterScreen> {
  final repo = sl<IHelpCenterRepository>();
  List<HelpCenterFieldsEntity> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    data = repo.getHelpCenterFields();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
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
              separatorBuilder: (context, index) => const SizedBox(height: TSize.s16),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    switch (data[index].name) {
                      case 'Customer Service':

                        // send a user model to the chat room screen
                        UserModel receiverUser = UserModel(
                          uid: 'dEHgKd4HtCO0jbopy4VoYP8cXfI3',
                          name: "Naser Sami",
                          email: "naser_ebedo@icloud.com",
                          profilePic:
                              "https://avatars.githubusercontent.com/u/136815868?v=4",
                          token:
                              "AMf-vBykMjkkkt4_OoIQTi9rL7sVMVCw64hWSLdOp9lJl5DN456q8EUS0_6I-nKnlPf7sRz4e2474qOsqppD8vD-vY3sRBHNPXyKCzmWFa7A3e5bJcGk7XZih1FCl-PMqgUfMXJNF_ZpYNDK5JEFEdW4MPzbKx7Jx07RwY5h1zHN8rqG2epgLsjSLq2WbTuIUA7x0kD7TqoAipzV49lkUrXYFj__7Cy7GuLsoDINCFePw1HWHoEw5UePGgXaB20zrGtAcP18TNcojp4vn6hcmQe6wFwujiiWOOhOh3N520YOpK5QitF3h1JQfLPPpbet2m9IDlyUGSo7UR2EdrnwVaidifmgj3gofQ",
                          phone: '',
                          address: '',
                          createdAt: DateTime(2025, 2, 20),
                          userType: UserType.admin,
                        );

                        String userName = receiverUser.name == ''
                            ? receiverUser.email.split('@')[0]
                            : receiverUser.name;

                        // if the use is the customer service, then
                        // we will navigate to the users list screen

                        if (sl<FirebaseAuth>().currentUser!.uid ==
                            'dEHgKd4HtCO0jbopy4VoYP8cXfI3') {
                          context.push(UsersListScreen.routeName);
                        } else {
                          context.push("${CustomerServiceScreen.routeName}/$userName",
                              extra: receiverUser);
                        }

                        break;
                      default:
                    }
                  },
                  minTileHeight: TSize.s64,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(TRadius.r08),
                    side:
                        BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.10)),
                  ),
                  leading: IconWidget(
                    name: data[index].icon,
                    color: colorScheme.onSurface,
                  ),
                  title: TextWidget(data[index].name),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Account'),
          actions: [
            NotificationsIconWidget(),
          ],
        ),
        body: const Center(
          child: Text('Account Screen'),
        ));
  }
}

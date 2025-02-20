import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/features/chat/_chat.dart';

class CustomerServiceScreen extends StatelessWidget {
  static const routeName = '/customer-service';
  const CustomerServiceScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ChatRoomScreen(
      user: user,
      appBarTitle: const Text('Customer Service'),
    );
  }
}

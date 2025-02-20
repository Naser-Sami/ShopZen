import 'package:flutter/material.dart';
import '/features/chat/_chat.dart';

class CustomerServiceScreen extends StatelessWidget {
  static const routeName = '/customer-service';
  const CustomerServiceScreen({super.key, required this.receiverUserId});

  final String receiverUserId;

  @override
  Widget build(BuildContext context) {
    return ChatRoomScreen(
      receiverUserId: receiverUserId,
    );
  }
}

import 'package:flutter/material.dart';
import '/config/_config.dart';

class MyOrdersScreen extends StatefulWidget {
  static const routeName = '/my-orders';
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        actions: const [NotificationsIconWidget()],
      ),
      body: const Center(
        child: Text('My Orders'),
      ),
    );
  }
}

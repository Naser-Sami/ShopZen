import 'package:flutter/material.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class CustomerServiceScreen extends StatelessWidget {
  static const routeName = '/customer-service';
  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Service'),
        actions: [
          NotificationsIconWidget(),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TPadding.p20),
            child: Column(
              children: [
                /// **Chat Body**
                CustomerServiceChatBody(),
                const SizedBox(height: TSize.s16),

                /// **Send Message Field**
                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      CustomerServiceSendMessageField(),
                      const SizedBox(width: TSize.s16),
                      CustomerServiceMicButton(),
                    ],
                  ),
                ),

                const SizedBox(height: TSize.s16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

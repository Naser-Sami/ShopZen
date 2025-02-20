import 'package:flutter/material.dart';

import '/config/_config.dart';
import '/features/_features.dart';

class ChatRoomScreen extends StatelessWidget {
  static const routeName = '/chat-room';
  const ChatRoomScreen({super.key, required this.receiverUserId});

  final String receiverUserId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
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
                /// **Chat Room Body**
                ChatRoomBody(
                  receiverUserId: receiverUserId,
                ),
                const SizedBox(height: TSize.s16),

                /// **Send Message Field**
                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SendMessageField(
                        receiverUserId: receiverUserId,
                      ),
                      const SizedBox(width: TSize.s16),
                      MicButton(),
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

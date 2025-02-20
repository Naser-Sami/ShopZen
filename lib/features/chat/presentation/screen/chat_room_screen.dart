import 'package:flutter/material.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/_features.dart';

class ChatRoomScreen extends StatelessWidget {
  static const routeName = '/chat-room';
  const ChatRoomScreen({super.key, required this.user, this.appBarTitle});

  final UserModel user;
  final Widget? appBarTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: appBarTitle ??
            Row(
              children: [
                CircleAvatar(
                  radius: TSize.s24,
                  backgroundImage: user.profilePic != ''
                      ? NetworkImage(
                          user.profilePic,
                        )
                      : null,
                ),
                const SizedBox(width: TSize.s08),
                Text(
                  user.name == '' ? user.email.split('@')[0] : user.name,
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
        centerTitle: false,
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
                  receiverUserId: user.uid,
                ),
                const SizedBox(height: TSize.s16),

                /// **Send Message Field**
                Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SendMessageField(
                        receiverUserId: user.uid,
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

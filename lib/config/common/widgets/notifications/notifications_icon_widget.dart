import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_zen/features/_features.dart';

import '/core/_core.dart';
import '/config/_config.dart';

class NotificationsIconWidget extends StatelessWidget {
  const NotificationsIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () async {
        log('NotificationsIconWidget onPressed');
        final fcmToken = await FirebaseMessaging.instance.getToken();
        await sl<INotificationsService>().sendNotification(
          fcmToken: fcmToken ?? '',
          title: "Test Notification",
          body: "This is a test notification",
          data: {
            "userId": "o9RL7kIghgd6aDFEALfqP1KyudZ2",
            "name": "Naser Sami Ebedo",
            "user": jsonEncode(
                sl<UserCubit>().state!.toMap()) // encode the map to a JSON string
          },
        );

        // "user":
        //     """{"name": "Naser Sami Ebedo","email": "inaser94@gmail.com","profilePic": "https://lh3.googleusercontent.com/a/...s96-c","token":"ya29.a0AXeO80S_GSEb8ubGCoRwH_q48l7jrKWb3g-BKtpRaNEDK2yQkAz-PjyFFeZFgNsd7kHeCcLSKaiJNhp60LdhoEW6ZSc1tv6AGegdBoOiNpqOqVmhAYrwM9iR-C6kXxxX1exs1yOPZqFH2ec8TXOC9AZHTet6I3tDVARVb7hOaCgYKAQgSARESFQHGX2MiewwsT_y5sCJfd1G1DdzB_w0175","fcmToken": '',"address": '',"phone": "+962795900291","createdAt": "2025-02-22T19:44:48.369057","dateOfBirth": "1994-09-13T00:00:00.000","userType": "user","gender": "male"}"""

        log('NotificationsIconWidget onPressed end');
      },
      icon: IconWidget(
        name: 'notification',
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:go_router/go_router.dart';
import '/features/_features.dart';
import '/core/_core.dart';

class ChatController {
  static void handleNotificationChatData(Map<String, dynamic> data) {
    try {
      final userId = data['userId'] as String;
      final userName = data['name'] as String;
      final userJson = data['user'] as String;
      // log('User data: $userJson');

      final user = UserModel.fromJson(jsonDecode(userJson), userId);

      try {
        // Get the current context safely
        final context = navigatorKey.currentContext;
        if (context != null) {
          GoRouter.of(context).push(
            "${ChatRoomScreen.routeName}/$userName",
            extra: user,
          );
        } else {
          log('Error: No valid context found');
        }
      } catch (e) {
        log('onMessageOpenedApp, Error navigating to chat room: $e');
      }
    } catch (e) {
      log('onMessageOpenedApp, Error handling notification data: $e');
    }
  }

  static void handleNotificationChatPayload(String payload) {
    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;

      final userId = data['userId'] as String;
      final userName = data['name'] as String;
      final userAsString = data['user'] as String;

      // 🔥 Ensure 'user' is parsed correctly
      final jsonUserString =
          userAsString.replaceAll("''", '""'); // Replace single quotes with double quotes

      final parsedUser = jsonDecode(jsonUserString) as Map<String, dynamic>;

      final user = UserModel.fromJson(parsedUser, userId);

      try {
        // Get the current context safely
        final context = navigatorKey.currentContext;
        if (context != null) {
          GoRouter.of(context).push(
            "${ChatRoomScreen.routeName}/$userName",
            extra: user,
          );
        } else {
          log('Error: No valid context found');
        }
      } catch (e) {
        log('Error navigating to chat room: $e');
      }

      log('Payload passed');
    } catch (e, stacktrace) {
      log('Error handling notification payload: $e');
      log(stacktrace.toString());
    }
  }
}

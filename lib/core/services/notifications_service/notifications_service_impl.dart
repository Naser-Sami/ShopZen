import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';

import '/core/_core.dart';

class NotificationsServiceImpl implements INotificationsService {
  final DioService dioService = DioService();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Saves the FCM token to Firestore for a given user
  @override
  Future<String> getFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      log("FCM Token: $token");

      return token ?? '';
    } catch (e) {
      log("Error getting FCM token: $e");
      return '';
    }
  }

  @override
  void isRefreshToken() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      log('TOken Refreshed');
    });
  }

  /// Retrieves an access token for Firebase Cloud Messaging
  @override
  Future<String> getAccessToken() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/notifications_key/shopzen-42af3-cf74f9e4396c.json',
      );
      final accountCredentials =
          auth.ServiceAccountCredentials.fromJson(jsonString);
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      final client =
          await auth.clientViaServiceAccount(accountCredentials, scopes);

      String accessToken = client.credentials.accessToken.data;
      log('Access token retrieved successfully $accessToken');
      return accessToken;
    } catch (e) {
      log('Error retrieving access token: $e');
      rethrow;
    }
  }

  /// Sends a push notification via Firebase Cloud Messaging (FCM)
  @override
  Future<void> sendNotification({
    required String fcmToken,
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    try {
      final String accessToken = await getAccessToken(); // Ensure this is valid
      const String fcmUrl =
          'https://fcm.googleapis.com/v1/projects/shopzen-42af3/messages:send';

      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      Map<String, dynamic> notificationPayload = {
        'message': {
          'token': fcmToken,
          'notification': {
            'title': title,
            'body': body,
          },
          'data': data,
          'android': {
            'priority': 'high',
            'notification': {
              'sound': 'custom_sound',
              'channel_id': 'high_importance_channel',
              'click_action': 'FLUTTER_NOTIFICATION_CLICK'
            },
          },
          'apns': {
            'headers': {
              'apns-priority': '10',
            },
            'payload': {
              'aps': {
                'sound': 'custom_sound.caf',
                'content-available': 1,
              },
            },
          },
        }
      };

      final response = await dioService.post(
        path: fcmUrl,
        headers: headers,
        data: notificationPayload,
      );

      log('✅ Notification response: $response');
      log('✅ Notification sent successfully to $fcmToken');
    } catch (e) {
      log('❌ Error sending notification: $e');
    }
  }

  /// Handles notification tap to navigate within the app
  @override
  void handleNotification(BuildContext context, Map<String, dynamic> data) {
    try {
      String? route = data['route'];
      if (route != null) {
        context.go(route);
      }
    } catch (e) {
      log('Error handling notification: $e');
    }
  }
}

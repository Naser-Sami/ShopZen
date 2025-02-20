import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_messaging_service.dart';

class FirebaseMessagingServiceImpl implements IFirebaseMessagingService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission for notifications
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');

      // Get FCM token
      String? token = await messaging.getToken();
      log("FCM Token: $token");

      // Save this token in Firestore for the current user
      if (token != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'fcmToken': token});
      }
    }

    // Listen for messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("New message: ${message.notification?.body}");

      // Show notification when received (foreground)
      _showNotification(message);
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'chat_messages', // Channel ID
      'Chat Messages', // Channel Name
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? "New Message",
      message.notification?.body ?? "You received a new message",
      platformChannelSpecifics,
    );
  }
}

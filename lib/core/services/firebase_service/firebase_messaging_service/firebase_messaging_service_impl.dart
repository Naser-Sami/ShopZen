import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'firebase_messaging_service.dart';

class FirebaseMessagingServiceImpl implements IFirebaseMessagingService {
  @override
  Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission for notifications
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    }

    // Listen for messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("New message: ${message.notification?.body}");
    });
  }
}

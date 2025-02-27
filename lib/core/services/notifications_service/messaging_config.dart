import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '/features/_features.dart';
import '/core/_core.dart';

class MessagingConfig {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> createNotificationChannel() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      sound: RawResourceAndroidNotificationSound('custom_sound'),
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> initFirebaseMessaging() async {
    await createNotificationChannel();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      
    );

    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialize the plugin.
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log('Notification response: ${response.payload}');
        if (response.payload != null) {
          _handleNotificationPayload(response.payload!);
        }
      },
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      log("message received");
      log("event: $event");

      try {
        RemoteNotification? notification = event.notification;
        log("notification body: ${notification?.body}");
        log("notification title: ${notification?.title}");

        await showNotification(notification, event.data);
      } catch (err) {
        log(err.toString());
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        log("getInitialMessage message: $message");
        sl<INotificationsService>()
            .handleNotification(navigatorKey.currentContext!, message.data);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      log("onMessageOpenedApp message: $event");
      _handleNotificationData(event.data);
    });
  }

  static void _handleNotificationData(Map<String, dynamic> data) {
    log('Handling notification data: $data');

    NotificationsType notificationType = EnumExtension.fromString(
      data['notificationType'] as String,
      NotificationsType.values,
      defaultValue: NotificationsType.normal, // Default case
    );

    switch (notificationType) {
      case NotificationsType.newMessage:
        ChatController.handleNotificationChatData(data);
        break;
      case NotificationsType.adminMessage:
        log('Admin Notification');
        break;
      default:
        log('Unknown notification type: $notificationType');
    }
  }

  static void _handleNotificationPayload(String payload) {
    log('Handling notification payload: $payload');

    final data = jsonDecode(payload) as Map<String, dynamic>;

    NotificationsType notificationType = EnumExtension.fromString(
      data['notificationType'] as String,
      NotificationsType.values,
      defaultValue: NotificationsType.normal, // Default case
    );

    switch (notificationType) {
      case NotificationsType.newMessage:
        ChatController.handleNotificationChatPayload(payload);
        break;
      case NotificationsType.adminMessage:
        // AdminController.handleNotificationAdminData(data);
        log('Admin Notification');
        break;
      default:
        log('Unknown notification type: $notificationType');
    }
  }

  static Future<void> showNotification(
      RemoteNotification? notification, Map<String, dynamic> messageData) async {
    // Notifications Details for Android
    AndroidNotificationDetails? androidNotificationsDetails =
        const AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      setAsGroupSummary: true,
    );

    // Notifications Details for iOS
    DarwinNotificationDetails? iosNotificationsDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'custom_sound.caf',
    );

    // Notifications Details
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationsDetails,
      iOS: iosNotificationsDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      notificationDetails,
      payload: jsonEncode(messageData),
    );

    log("notification sent");
  }

  @pragma('vm:entry-point')
  static Future<void> messageHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    if (message.notification != null) {
      final data = message.data;
      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title,
        message.notification?.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(data), // Pass data as payload
      );
    }
  }
}

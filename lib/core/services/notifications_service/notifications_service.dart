import 'package:flutter/material.dart';
import '/core/_core.dart';

abstract class INotificationsService {
  Future<String> getFCMToken();
  void isRefreshToken();
  Future<String> getAccessToken();
  Future<void> sendNotification(
      {required String fcmToken,
      required String title,
      required String body,
      required NotificationsType notificationType,
      required Map<String, String> data});
  void handleNotification(BuildContext context, Map<String, dynamic> data);
}

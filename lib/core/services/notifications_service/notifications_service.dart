import 'package:flutter/material.dart';

abstract class INotificationsService {
  Future<String> getFCMToken();
  void isRefreshToken();
  Future<String> getAccessToken();
  Future<void> sendNotification(
      {required String fcmToken,
      required String title,
      required String body,
      required Map<String, dynamic> data});
  void handleNotification(BuildContext context, Map<String, dynamic> data);
}

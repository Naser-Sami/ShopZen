import 'package:flutter/material.dart';

abstract class INotificationsService {
  Future<String> getFCMToken();
  void isRefreshToken();
  Future<String> getAccessToken();
  Future<void> sendNotification(
      {required String token,
      required String title,
      required String body,
      required Map<String, String> data});
  void handleNotification(BuildContext context, Map<String, dynamic> data);
}

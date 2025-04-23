abstract class INotificationsService {
  Future<String> getFCMToken();
  void isRefreshToken();
  Future<String> getAccessToken();
  Future<void> sendNotification(
      {required String fcmToken,
      required String title,
      required String body,
      required Map<String, String> data});
  void handleNotification(Map<String, dynamic> data);
}

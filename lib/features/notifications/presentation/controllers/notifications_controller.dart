import 'package:cloud_firestore/cloud_firestore.dart';

import '/core/_core.dart';
import '/features/_features.dart';

class NotificationsController {
  static Stream<List<NotificationsModel>> getNotifications() {
    final userId = sl<UserCubit>().state?.uid;
    if (userId == null) {
      return Stream.value([]); // Prevents crash if user is null
    }

    return FirebaseFirestore.instance
        .collection('notifications/${sl<UserCubit>().state!.uid}/notifications-list')
        .snapshots() // 🔥 Listen to real-time updates
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NotificationsModel.fromMap(doc.data(), doc.id))
              .toList()
              .sorted(
                (a, b) => b.createdAt.compareTo(a.createdAt),
              ),
        );
  }

  // Mark a notification as read
  static Future<Result<void>> markNotificationAsRead(String notificationId) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications/${sl<UserCubit>().state!.uid}/notifications-list')
          .doc(notificationId)
          .update({'isRead': true}); // ✅ Update the flag to true

      return const Result.success(null);
    } on FirebaseException catch (e) {
      return Result.failure("Failed to mark notification as read: ${e.message}");
    }
  }

  // Delete a notification
  static Future<Result<void>> deleteNotification(String notificationId) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications/${sl<UserCubit>().state!.uid}/notifications-list')
          .doc(notificationId)
          .delete();
      return const Result.success(null);
    } on FirebaseException catch (e) {
      return Result.failure("Failed to delete notification: ${e.message}");
    }
  }
}

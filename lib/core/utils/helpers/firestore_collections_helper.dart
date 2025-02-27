import 'dart:developer';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/features/_features.dart';
import '/core/_core.dart';

Future<void> createOrUpdateUserCollection(UserCredential credential) async {
  final fcmToken = await sl<INotificationsService>().getFCMToken();
  final accessToken = await credential.user?.getIdToken(true);
  final userId = credential.user?.uid ?? "";

  if (userId.isEmpty) return;

  final result = await sl<IFirestoreService<UserModel>>().getDocument('users/$userId');

  result.handle(
    // if user exists, update the user's FCM token and access token
    onSuccess: (userData) async {
      await sl<IFirestoreService<UserModel>>().updateDocument(
        'users/$userId',
        {
          'fcmToken': fcmToken,
          'token': accessToken,
        },
      );
      log('FCM token updated securely for existing user');

      // TODO:: remove this later
      if (credential.user?.uid != null) {
        createOrSendNotification(
          uid: credential.user!.uid,
          fcmToken: fcmToken,
          title: "Welcome to ${AppConfig.appName}",
          body: "Welcome to ${AppConfig.appName}, we hope you enjoy your stay.",
          senderId: AppConfig.adminID,
        );
      }
    },

    // if user doesn't exist, create a new user document
    onError: (_) async {
      final user = UserModel(
        uid: userId,
        name: credential.user?.displayName ?? "",
        email: credential.user?.email ?? "",
        profilePic: credential.user?.photoURL ?? "",
        phone: credential.user?.phoneNumber ?? "",
        address: "",
        createdAt: DateTime.now(),
        dateOfBirth: "",
        userType: UserType.user,
        token: accessToken ?? "",
        fcmToken: fcmToken,
        gender: "",
      );

      // Create the user document in Firestore
      final createResult = await sl<IFirestoreService<UserModel>>().setDocument(
        'users/$userId',
        user.toMap(),
      );

      // Handle the result of creating the user document
      createResult.handle(
        onSuccess: (_) => log('User document created securely'),
        onError: (error) => log('Error creating user document: $error'),
      );

      if (credential.user?.uid != null) {
        createOrSendNotification(
          uid: credential.user!.uid,
          fcmToken: fcmToken,
          title: "Welcome to ${AppConfig.appName}",
          body: "Welcome to ${AppConfig.appName}, we hope you enjoy your stay.",
          senderId: AppConfig.adminID,
        );
      }
    },
  );
}

Future<void> createOrSendNotification({
  required String uid,
  required String fcmToken,
  required String title,
  required String body,
  Map<String, String>? data,
  String? icon,
  required String senderId,
  NotificationsType type = NotificationsType.adminMessage,
}) async {
  try {
    if (uid.isEmpty) return;

    // Generate a unique ID for the notification
    final uuid = const Uuid();

    // Create a welcome notification
    final notificationsModel = NotificationsModel(
      id: uuid.v4(),
      title: title,
      body: body,
      createdAt: DateTime.now(),
      isRead: false,
      icon: icon ?? 'LogoIcon',
      type: type.name,
      senderId: senderId,
    );

    // Create a new notification document
    final createResult = await sl<IFirestoreService<NotificationsModel>>().addDocument(
      'notifications/$uid/notifications-list',
      notificationsModel.toMap(),
    );

    if (data != null) {
      data = {
        ...data,
        "notificationType": type.name,
      };
    } else {
      data = {
        "notificationType": type.name,
      };
    }

    // Handle the result of creating the notification document
    createResult.handle(
      onSuccess: (_) {
        log('Notification document created successfully');

        try {
          sl<INotificationsService>().sendNotification(
            fcmToken: fcmToken,
            title: title,
            body: body,
            data: data!,
          );
        } catch (e) {
          log('Error sending notification On Send Message: $e');
        }
      },
      onError: (error) => log('Error creating notification document: $error'),
    );
  } catch (e) {
    log('Error creating notification document: $e');
  }
}

// Decrypt when reading from Firestore
// When retrieving the token:

// final decryptedToken = EncryptionHelper.decrypt(userData.token);
// final decryptedFcmToken = EncryptionHelper.decrypt(userData.fcmToken);

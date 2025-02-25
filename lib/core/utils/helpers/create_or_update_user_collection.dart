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
      createNotificationCollection(credential);
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

      createNotificationCollection(credential);
    },
  );
}

Future<void> createNotificationCollection(UserCredential credential) async {
  try {
    final fcmToken = await sl<INotificationsService>().getFCMToken();
    final userId = credential.user?.uid ?? "";

    if (userId.isEmpty) return;

    // Generate a unique ID for the notification
    final uuid = Uuid();

    // Create a welcome notification
    final data = NotificationsModel(
      id: uuid.v4(),
      title: "ShopZen",
      body: "Welcome to ShopZen",
      createdAt: DateTime.now(),
      isRead: false,
      icon: 'LogoIcon',
      type: NotificationsType.adminMessage.name,
    );

    // Create a new notification document
    final createResult = await sl<IFirestoreService<NotificationsModel>>().setDocument(
      'notifications/$userId',
      data.toMap(),
    );

    // Handle the result of creating the notification document
    createResult.handle(
      onSuccess: (_) {
        log('Notification document created successfully');

        try {
          sl<INotificationsService>().sendNotification(
            fcmToken: fcmToken,
            title: "Welcome to ShopZen",
            body: "Find the best deals on your favorite products",
            data: {
              "notificationType": NotificationsType.adminMessage.name,
            },
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

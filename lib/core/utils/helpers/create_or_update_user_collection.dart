import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

import '/core/_core.dart';

Future<void> createOrUpdateUserCollection(UserCredential credential) async {
  // ignore: non_constant_identifier_names
  final FCM_TOKEN = await sl<INotificationsService>().getFCMToken();
  final accessToken = await credential.user?.getIdToken(true);
  final userId = credential.user?.uid ?? "";

  if (userId.isEmpty) return;

  final result = await sl<IFirestoreService<UserModel>>().getDocument('users/$userId');

  result.handle(
    onSuccess: (userData) async {
      await sl<IFirestoreService<UserModel>>().updateDocument(
        'users/$userId',
        {
          'fcmToken': FCM_TOKEN,
          'token': accessToken,
        },
      );
      log('FCM token updated securely for existing user');
    },
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
        fcmToken: FCM_TOKEN,
        gender: "",
      );

      final createResult = await sl<IFirestoreService<UserModel>>().setDocument(
        'users/$userId',
        user.toMap(),
      );

      createResult.handle(
        onSuccess: (_) => log('User document created securely'),
        onError: (error) => log('Error creating user document: $error'),
      );
    },
  );
}

// Decrypt when reading from Firestore
// When retrieving the token:

// final decryptedToken = EncryptionHelper.decrypt(userData.token);
// final decryptedFcmToken = EncryptionHelper.decrypt(userData.fcmToken);

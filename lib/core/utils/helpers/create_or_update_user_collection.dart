import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_zen/core/_core.dart';

import 'encryption_helper.dart';

Future<void> createOrUpdateUserCollection(UserCredential credential) async {
  // ignore: non_constant_identifier_names
  final FCM_TOKEN = await sl<INotificationsService>().getFCMToken();
  final userId = credential.user?.uid ?? "";

  if (userId.isEmpty) return;

  final result = await sl<IFirestoreService<UserModel>>().getDocument('users/$userId');

  // Secure storage
  await sl<SecureStorageService>()
      .write('access-token', credential.credential?.accessToken ?? "");
  await sl<SecureStorageService>().write('fcm-token', FCM_TOKEN);

  final accessToken = await sl<SecureStorageService>().read('access-token');
  final fcmToken = await sl<SecureStorageService>().read('fcm-token');

  // 🔐 Encrypt the tokens
  final encryptedToken = EncryptionHelper.encrypt(accessToken ?? "");
  final encryptedFcmToken = EncryptionHelper.encrypt(fcmToken ?? "");

  result.handle(
    onSuccess: (userData) async {
      await sl<IFirestoreService<UserModel>>().updateDocument(
        'users/$userId',
        {
          'fcmToken': encryptedFcmToken,
          'token': encryptedToken,
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
        dateOfBirth: '',
        userType: UserType.user,
        token: encryptedToken,
        fcmToken: encryptedFcmToken,
        gender: '',
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

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_zen/core/_core.dart';

Future<void> createOrUpdateUserCollection(UserCredential credential) async {
  final fcmToken = await sl<INotificationsService>().getFCMToken();
  final userId = credential.user?.uid ?? "";

  if (userId.isEmpty) return;

  // Fetch user document
  final result = await sl<IFirestoreService<UserModel>>().getDocument('users/$userId');

  result.handle(
    onSuccess: (userData) async {
      // ✅ If user exists, update FCM token
      await sl<IFirestoreService<UserModel>>().updateDocument(
        'users/$userId',
        {
          'fcmToken': fcmToken,
          'token': credential.credential?.accessToken,
        },
      );
      log('FCM token updated for existing user');
    },
    onError: (_) async {
      // ✅ If user does not exist, create a new document
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
        token: credential.credential?.accessToken ?? "",
        fcmToken: fcmToken,
        gender: '',
      );

      final createResult = await sl<IFirestoreService<UserModel>>().setDocument(
        'users/$userId',
        user.toMap(),
      );

      createResult.handle(
        onSuccess: (_) => log('User document created successfully'),
        onError: (error) => log('Error creating user document: $error'),
      );
    },
  );
}

// Future<void> _createUserCollection(UserCredential credential) async {
//   // Create a new user document if not exist in Firestore
//   final fcmToken = await sl<INotificationsService>().getFCMToken();
//   sl<FirebaseFirestore>().collection('users').doc(credential.user?.uid).set(
//         UserModel(
//           uid: credential.user?.uid ?? "",
//           name: credential.user?.displayName ?? "",
//           email: credential.user?.email ?? "",
//           profilePic: credential.user?.photoURL ?? "",
//           token: credential.user?.refreshToken ?? "",
//           phone: credential.user?.phoneNumber ?? "",
//           address: "",
//           createdAt: DateTime.now(),
//           userType: UserType.user,
//           fcmToken: fcmToken,
//         ).toMap(),
//       );
// }

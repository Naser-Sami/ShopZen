import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/core/_core.dart';

class FirebaseAuthServiceImpl implements IFirebaseAuthService {
  final FirebaseAuth auth;

  FirebaseAuthServiceImpl({
    required this.auth,
  });

  @override
  Stream<User?> authStateChanges() {
    try {
      auth.authStateChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out! "authStateChanges"');
        } else {
          log('User is signed in! "authStateChanges"');
        }
      });

      return auth.authStateChanges();
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    }
  }

  @override
  Stream<User?> idTokenChanges() {
    try {
      auth.idTokenChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out! "idTokenChanges" ');
        } else {
          log('User is signed in! "idTokenChanges"');
        }
      });

      return auth.idTokenChanges();
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    }
  }

  @override
  Stream<User?> userChanges() {
    try {
      auth.userChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out! "userChanges" ');
        } else {
          log('User is signed in! "userChanges"');
        }
      });

      return auth.idTokenChanges();
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    }
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _createUserCollection(credential);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _createUserCollection(credential);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> _createUserCollection(UserCredential credential) async {
    // Create a new user document if not exist in Firestore
    final fcmToken = await sl<INotificationsService>().getFCMToken();
    sl<FirebaseFirestore>().collection('users').doc(credential.user?.uid).set(
          UserModel(
            uid: credential.user?.uid ?? "",
            name: credential.user?.displayName ?? "",
            email: credential.user?.email ?? "",
            profilePic: credential.user?.photoURL ?? "",
            token: credential.user?.refreshToken ?? "",
            phone: credential.user?.phoneNumber ?? "",
            address: "",
            createdAt: DateTime.now(),
            userType: UserType.user,
            fcmToken: fcmToken,
          ).toMap(),
        );
  }
}

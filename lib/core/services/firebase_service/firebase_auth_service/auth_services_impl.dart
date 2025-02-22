import 'dart:developer';

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

      createOrUpdateUserCollection(credential);

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

      createOrUpdateUserCollection(credential);

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
}

import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuthService {
  Stream<User?> authStateChanges();
  Stream<User?> idTokenChanges();
  Stream<User?> userChanges();
  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password});
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signOut();
}

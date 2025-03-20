import 'package:firebase_auth/firebase_auth.dart' show UserCredential;

abstract class ISocialAuthRepo {
  Future<UserCredential> googleAuth();
  Future<UserCredential> appleAuth();
  Future<UserCredential> xAuth();
  Future<UserCredential> facebookAuth();
  Future<UserCredential> githubAuth();
}

import 'package:firebase_auth/firebase_auth.dart';

abstract class ISocialSignInService {
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithFacebook();
  Future<UserCredential> signInWithApple();
  Future<UserCredential> signInWithGitHub();
  Future<UserCredential> signInWithX();
}

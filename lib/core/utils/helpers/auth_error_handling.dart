// Error Handling Class
import 'package:firebase_auth/firebase_auth.dart';

class AuthErrorHandler {
  static String handle(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'Account disabled';
      case 'user-not-found':
        return 'Account not found';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'Email already registered';
      case 'operation-not-allowed':
        return 'Sign-in method not enabled';
      case 'weak-password':
        return 'Password is too weak';
      case 'account-exists-with-different-credential':
        return 'Account exists with different sign-in method';
      case 'invalid-credential':
        return 'Invalid authentication credentials';
      default:
        return e.message ?? 'Authentication failed';
    }
  }
}

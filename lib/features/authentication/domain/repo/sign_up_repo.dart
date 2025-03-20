import 'package:firebase_auth/firebase_auth.dart' show User;

abstract class ISignUpRepo {
  Future<User?> signUpWithEmail(
    String email,
    String password,
  );
}

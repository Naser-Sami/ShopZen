import 'package:firebase_auth/firebase_auth.dart' show User;

abstract class ILoginRepo {
  Future<User?> loginWithEmail(String email, String password);
}

import 'package:firebase_auth/firebase_auth.dart' show User;

import '/core/_core.dart' show sl, IFirebaseAuthService;
import '/features/_features.dart' show ILoginRepo;

class LoginRepoImpl implements ILoginRepo {
  @override
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      return await sl<IFirebaseAuthService>()
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}

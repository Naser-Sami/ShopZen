import 'package:firebase_auth/firebase_auth.dart' show User;

import '/core/_core.dart' show sl, IFirebaseAuthService;
import '/features/_features.dart' show ISignUpRepo;

class SignUpRepoImpl implements ISignUpRepo {
  @override
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      return await sl<IFirebaseAuthService>()
          .signUpWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}

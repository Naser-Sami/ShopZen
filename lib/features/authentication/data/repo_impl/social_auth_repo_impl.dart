import 'package:firebase_auth/firebase_auth.dart' show UserCredential;

import '/core/_core.dart' show sl, ISocialSignInService;
import '/features/_features.dart' show ISocialAuthRepo;

class SocialAuthRepoImpl implements ISocialAuthRepo {
  @override
  Future<UserCredential> appleAuth() async {
    try {
      return await sl<ISocialSignInService>().signInWithApple();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> facebookAuth() async {
    try {
      return await sl<ISocialSignInService>().signInWithFacebook();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> githubAuth() async {
    try {
      return await sl<ISocialSignInService>().signInWithGitHub();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> googleAuth() async {
    try {
      return await sl<ISocialSignInService>().signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> xAuth() async {
    try {
      return await sl<ISocialSignInService>().signInWithX();
    } catch (e) {
      rethrow;
    }
  }
}

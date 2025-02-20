import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '/core/_core.dart';

// Reference: https://firebase.google.com/docs/auth/flutter/federated-auth#ios+-and-android_2

class SocialSignInServiceImpl implements ISocialSignInService {
  final FirebaseAuth auth;

  SocialSignInServiceImpl({required this.auth});

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await auth.signInWithCredential(credential);
      _createUserCollection(userCredential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    } catch (e) {
      throw 'Google sign in failed: ${e.toString()}';
    }
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken?.tokenString ?? '');

      // Once signed in, return the UserCredential
      final userCredential = await auth.signInWithCredential(facebookAuthCredential);
      _createUserCollection(userCredential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    } catch (e) {
      throw 'Facebook sign in failed: ${e.toString()}';
    }
  }

  @override
  Future<UserCredential> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();

      UserCredential userCredential = await auth.signInWithPopup(appleProvider);
      // Keep the authorization code returned from Apple platforms
      String? authCode = userCredential.additionalUserInfo?.authorizationCode;
      // Revoke Apple auth token
      await auth.revokeTokenWithAuthorizationCode(authCode!);
      _createUserCollection(userCredential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    } catch (e) {
      throw 'Apple sign in failed: ${e.toString()}';
    }
  }

  @override
  Future<UserCredential> signInWithGitHub() async {
    try {
      // Trigger the sign-in flow
      GithubAuthProvider githubProvider = GithubAuthProvider();

      // Sign in with Firebase
      UserCredential userCredential = await auth.signInWithProvider(githubProvider);

      _createUserCollection(userCredential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthErrorHandler.handle(e);
    } catch (e) {
      throw 'Github sign in failed: ${e.toString()}';
    }
  }

  @override
  Future<UserCredential> signInWithX() {
    // TODO: implement signInWithX
    throw UnimplementedError();
  }

  void _createUserCollection(UserCredential credential) {
    // Create a new user document if not exist in Firestore
    sl<FirebaseFirestore>().collection('users').doc(credential.user?.uid).set(
          UserModel(
            uid: credential.user?.uid ?? "",
            name: credential.user?.displayName ?? "",
            email: credential.user?.email ?? "",
            profilePic: credential.user?.photoURL ?? "",
            token: credential.user?.refreshToken ?? "",
            phone: credential.user?.phoneNumber ?? "",
            address: "",
            createdAt: DateTime.now(),
            userType: UserType.user,
          ).toMap(),
        );
  }
}

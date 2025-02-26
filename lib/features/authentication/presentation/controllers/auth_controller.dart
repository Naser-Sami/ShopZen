import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/features/_features.dart';
import '/core/_core.dart';

class AuthController {
  List<String> socialMediaLogin = ['google', 'apple', 'x', 'facebook', 'github'];

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      await sl<ISocialSignInService>().signInWithGoogle().then((v) {
        _getCurrentUserData();
        if (context.mounted) {
          // for apis you can use the user credential to get the user details from the api
          _navToHomeScreen(context, "${v.user?.email}, Login successful");
        }
      });
    } catch (e) {
      if (context.mounted) {
        ToastNotification.showErrorNotification(context, message: e.toString());
      }
    }
  }

  Future<void> loginWithApple(BuildContext context) async {
    try {
      await sl<ISocialSignInService>().signInWithApple().then((v) {
        _getCurrentUserData();
        if (context.mounted) {
          _navToHomeScreen(context, "${v.user?.email}, Login successful");
        }
      });
    } catch (e) {
      if (context.mounted) {
        ToastNotification.showErrorNotification(context, message: e.toString());
      }
    }
  }

  Future<void> loginWithX(BuildContext context) async {
    try {
      await sl<ISocialSignInService>().signInWithX().then((v) {
        _getCurrentUserData();
        if (context.mounted) {
          _navToHomeScreen(context, "${v.user?.email}, Login successful");
        }
      });
    } catch (e) {
      if (context.mounted) {
        ToastNotification.showErrorNotification(context, message: e.toString());
      }
    }
  }

  Future<void> loginWithFacebook(BuildContext context) async {
    try {
      await sl<ISocialSignInService>().signInWithFacebook().then((v) {
        _getCurrentUserData();
        if (context.mounted) {
          _navToHomeScreen(context, "${v.user?.email}, Login successful");
        }
      });
    } catch (e) {
      if (context.mounted) {
        ToastNotification.showErrorNotification(context, message: e.toString());
      }
    }
  }

  Future<void> loginWithGithub(BuildContext context) async {
    try {
      await sl<ISocialSignInService>().signInWithGitHub().then((v) {
        _getCurrentUserData();
        if (context.mounted) {
          _navToHomeScreen(context, "${v.user?.email}, Login successful");
        }
      });
    } catch (e) {
      if (context.mounted) {
        ToastNotification.showErrorNotification(context, message: e.toString());
      }
    }
  }

  Future<void> loginWithEmail(BuildContext context,
      {required String email, required String password}) async {
    try {
      await sl<IFirebaseAuthService>()
          .signInWithEmailAndPassword(email: email, password: password)
          .then((v) {
        _getCurrentUserData();
        if (context.mounted) {
          _navToHomeScreen(context, "${v?.email}, Login successful");
        }
      });
    } catch (e) {
      if (context.mounted) {
        ToastNotification.showErrorNotification(context, message: e.toString());
      }
    }
  }

  Future<void> signUpWithEmail(BuildContext context,
      {required String email, required String password}) async {
    try {
      await sl<IFirebaseAuthService>()
          .signUpWithEmailAndPassword(email: email, password: password)
          .then((v) {
        _getCurrentUserData();
        if (context.mounted) {
          _navToHomeScreen(context, "${v?.email}, Sign Up successfully");
        }
      });
    } catch (e) {
      if (context.mounted) {
        ToastNotification.showErrorNotification(context, message: e.toString());
      }
    }
  }

  Future<void> _getCurrentUserData() async {
    await sl<UserCubit>().getCurrentUserData(sl<FirebaseAuth>().currentUser!.uid);
  }

  void _navToHomeScreen(BuildContext context, String msg) {
    if (sl<FirebaseAuth>().currentUser == null) {
      context.push(AccessLocationScreen.routeName);
    } else {
      context.go(BottomNavigationBarWidget.routeName);
      ToastNotification.showSuccessNotification(context, message: msg);
    }
  }
}

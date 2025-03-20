import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/_core.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  /// Fetch user data and listen for changes
  Future<void> getCurrentUserData() async {
    final result = await sl<IFirestoreService<UserModel>>()
        .getDocument('users/${sl<FirebaseAuth>().currentUser!.uid}');
    result.handle(
      onSuccess: (user) {
        // log('User data: ${user.toString()}');
        emit(user);
      },
      onError: (error) {
        log(error.toString());
        ToastNotification.showErrorNotification(navigatorKey.currentContext!,
            message: error.toString());
      },
    );
  }
}

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/core/_core.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  /// Fetch user data and listen for changes
  Future<void> getCurrentUserData(String uid) async {
    final result = await sl<IFirestoreService<UserModel>>().getDocument('users/$uid');
    result.handle(onSuccess: (user) {
      log('User data fetched successfully $user');
      emit(user);
    }, onError: (error) {
      log(error.toString());
      ToastNotification.showErrorNotification(NavigationService.rootNavigator,
          message: error.toString());
    });
  }

  /// Update user data
  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update(data);
  }
}

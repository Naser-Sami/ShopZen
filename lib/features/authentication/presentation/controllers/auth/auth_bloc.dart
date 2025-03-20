import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '/core/_core.dart'
    show
        sl,
        IFirestoreService,
        IFirebaseAuthService,
        Result,
        ResultExtensions,
        UserModel,
        SecureStorageService;
import '/features/_features.dart'
    show ILoginRepo, ISignUpRepo, ISocialAuthRepo, UserCubit;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ILoginRepo loginRepo;
  final ISignUpRepo signUpRepo;
  final ISocialAuthRepo socialAuthRepo;
  final SecureStorageService secureStorageService;

  AuthBloc(
      {required this.loginRepo,
      required this.signUpRepo,
      required this.socialAuthRepo,
      required this.secureStorageService})
      : super(Unauthenticated()) {
    on<AppStartedEvent>(_onAppStartedEvent);
    on<AppleAuthEvent>(_onAppleAuthEvent);
    on<GoogleAuthEvent>(_onGoogleAuthEvent);
    on<FacebookAuthEvent>(_onFacebookAuthEvent);
    on<GithubAuthEvent>(_onGithubAuthEvent);
    on<XAuthEvent>(_onXAuthEvent);
    on<LoginEvent>(_onLoginEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onAppStartedEvent(
      AppStartedEvent event, Emitter<AuthState> emit) async {
    try {
      final token = await secureStorageService.read('token');

      if (token != null) {
        await _handleAuthResult(sl<FirebaseAuth>().currentUser?.uid, emit);
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAppleAuthEvent(
      AppleAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userCredential = await socialAuthRepo.appleAuth();
      await _handleAuthResult(userCredential.user?.uid, emit);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onGoogleAuthEvent(
      GoogleAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userCredential = await socialAuthRepo.googleAuth();
      await _handleAuthResult(userCredential.user?.uid, emit);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onFacebookAuthEvent(
      FacebookAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userCredential = await socialAuthRepo.facebookAuth();
      await _handleAuthResult(userCredential.user?.uid, emit);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onGithubAuthEvent(
      GithubAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userCredential = await socialAuthRepo.githubAuth();
      await _handleAuthResult(userCredential.user?.uid, emit);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onXAuthEvent(XAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userCredential = await socialAuthRepo.xAuth();
      await _handleAuthResult(userCredential.user?.uid, emit);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginRepo.loginWithEmail(event.email, event.password);
      await _handleAuthResult(user?.uid, emit);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user =
          await signUpRepo.signUpWithEmail(event.email, event.password);
      await _handleAuthResult(user?.uid, emit);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await secureStorageService.delete('token');
      await sl<IFirebaseAuthService>().signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<Result<UserModel>> _currentUser(String? uid) async {
    await sl<UserCubit>().getCurrentUserData();
    return await sl<IFirestoreService<UserModel>>().getDocument('users/$uid');
  }

  Future<void> _handleAuthResult(String? uid, Emitter<AuthState> emit) async {
    try {
      final result = await _currentUser(uid);

      await result.handleAsync(
        onSuccess: (user) async {
          if (user.uid.isEmpty) {
            emit(const AuthFailure('Authentication failed: No user ID'));
            return;
          }

          await secureStorageService.write('token', user.token);
          emit(Authenticated(user: user, token: user.token));
        },
        onError: (error) => emit(AuthFailure(error)),
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}

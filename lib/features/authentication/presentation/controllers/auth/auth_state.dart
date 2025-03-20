part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class Unauthenticated extends AuthState {}

final class AuthLoading extends AuthState {}

final class Authenticated extends AuthState {
  final UserModel user;
  final String token;

  const Authenticated({required this.user, required this.token});

  // copy with method
  Authenticated copyWith({
    UserModel? user,
    String? token,
  }) {
    return Authenticated(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [user, token];
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

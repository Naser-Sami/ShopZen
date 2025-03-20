part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AppStartedEvent extends AuthEvent {}

final class AppleAuthEvent extends AuthEvent {}

final class GoogleAuthEvent extends AuthEvent {}

final class FacebookAuthEvent extends AuthEvent {}

final class GithubAuthEvent extends AuthEvent {}

final class XAuthEvent extends AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

final class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

final class LogoutEvent extends AuthEvent {}

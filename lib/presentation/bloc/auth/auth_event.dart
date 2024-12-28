part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignin extends AuthEvent {}

class AuthSignOut extends AuthEvent {}

class AuthCreateAccount extends AuthEvent {
  final String email;
  final String password;
  const AuthCreateAccount({required this.email, required this.password});
}

class AuthSigninWithEmail extends AuthEvent {
  final String email;
  final String password;

  const AuthSigninWithEmail({required this.email, required this.password});
}

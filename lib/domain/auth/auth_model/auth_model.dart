// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String userName;
  final String email;
  final String password;
  final String? photoURL;
  final AuthenticationType authType;
  const AuthModel(
      {required this.userName,
      required this.email,
      required this.password,
      this.photoURL,
      this.authType = AuthenticationType.google});

  @override
  String toString() {
    return 'AuthModel(userName: $userName, email: $email, password: $password, photoURL: $photoURL, authType: $authType)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userName, email, password, photoURL, authType];
}

enum AuthenticationType {
  google,
  emailAndPass,
}

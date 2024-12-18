// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String? authorizationCode;
  final bool? isNewUser;
  final String? userName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  const AuthModel({
    this.authorizationCode,
    this.isNewUser,
    this.userName,
    this.email,
    this.phoneNumber,
    this.photoURL,
  });

  @override
  String toString() {
    return 'AuthModel(authorizationCode: $authorizationCode, isNewUser: $isNewUser, userName: $userName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        authorizationCode,
        isNewUser,
        userName,
        email,
        phoneNumber,
        photoURL,
      ];
}

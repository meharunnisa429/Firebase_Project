import 'dart:async';
import 'package:firebase_project/domain/auth/auth_model/auth_model.dart';
import 'package:firebase_project/domain/auth/auth_repository/auth_repository.dart';
import 'package:firebase_project/package/firebase/firebase_auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> signInWithGoogle() async {
    await FirebaseAuthService().signinWithGoogle();
  }

  @override
  Future<AuthModel> getUserInfo() async {
    return await FirebaseAuthService().getUserInfo();
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuthService().signOut();
  }

  @override
  Future<void> signInWithEmailAndPass(
      {required String email, required String password}) async {
    await FirebaseAuthService()
        .signInWithEmailAndPass(email: email, password: password);
  }

  @override
  Future<void> createAccountWithEmailAndPass(
      {required String email, required String password}) async {
    await FirebaseAuthService()
        .createAccountWithEmailAndPass(email: email, password: password);
  }
}

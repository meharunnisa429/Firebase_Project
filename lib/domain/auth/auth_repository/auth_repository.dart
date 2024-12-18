import 'package:firebase_project/domain/auth/auth_model/auth_model.dart';

abstract class AuthRepository {
  Future<void> signInWithGoogle();
  Future<AuthModel> getUserInfo();
  Future<void> signOut();
  Future<void> signInWithEmailAndPass(
      {required String email, required String password});
}

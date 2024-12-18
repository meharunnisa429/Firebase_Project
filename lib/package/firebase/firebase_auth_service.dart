import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/domain/auth/auth_model/auth_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  FirebaseAuthService._();
  static final _instance = FirebaseAuthService._();
  factory FirebaseAuthService() => _instance;
  late final StreamSubscription<User?> authStateListener;

  Future<void> signinWithGoogle() async {
    //Trigger the Authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      //create a new credential

      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      UserCredential? user =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw "Error in code";
    }
  }

  Future<AuthModel> getUserInfo() async {
    AuthModel usermodel = const AuthModel();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      log("inside user");
      usermodel = AuthModel(
          phoneNumber: user.phoneNumber,
          photoURL: user.photoURL,
          email: user.email);
    }

    return usermodel;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> singInWithEmailAndPass({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }
}

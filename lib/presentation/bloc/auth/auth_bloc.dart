import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_project/domain/auth/auth_model/auth_model.dart';
import 'package:firebase_project/domain/auth/auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthSignin>(_signin);
    on<AuthSignOut>(_signOut);
    on<AuthCreateAccount>(_createAccount);
    on<AuthSigninWithEmail>(_signinWithEmail);
  }

  _signin(AuthSignin event, Emitter<AuthState> emit) async {
    try {
      log("inside  bloc");
      await authRepository.signInWithGoogle();
      AuthModel userModel = await authRepository.getUserInfo();

      emit(AuthSuccess(authModel: userModel));
    } catch (e) {
      emit(AuthError());
    }
  }

  

  _signOut(AuthSignOut event, Emitter<AuthState> emit) async {
    try {
      await authRepository.signOut();

      emit(AuthSignOutSuccess());
    } catch (e) {
      emit(AuthSignOutError());
    }
  }

  _createAccount(AuthCreateAccount event, Emitter<AuthState> emit) async {
    try {
      log("inside  bloc");
      await authRepository.createAccountWithEmailAndPass(
          email: event.email, password: event.password);
  AuthModel userModel = await authRepository.getUserInfo();
      emit(AuthSuccess(authModel: userModel));
    } catch (e) {
      emit(AuthError());
    }
  }

  _signinWithEmail(AuthSigninWithEmail event, Emitter<AuthState> emit) async {
    try {
      log("inside  bloc");
      await authRepository.signInWithEmailAndPass(
          email: event.email, password: event.password);

      AuthModel userModel = await authRepository.getUserInfo();

      emit(AuthSuccess(authModel: userModel));
    } catch (e) {
      emit(AuthError());
    }
  }
}

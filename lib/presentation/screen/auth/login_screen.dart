import 'dart:developer';

import 'package:firebase_project/presentation/bloc/auth/auth_bloc.dart';
import 'package:firebase_project/presentation/screen/user/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _obscurepassword = true;

  final _fomKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _fomKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // email
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                      labelStyle: TextStyle(color: Colors.black38),
                      floatingLabelStyle: TextStyle(color: Colors.black87),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "email  is empty";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // password
                  TextFormField(
                    obscureText: _obscurepassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      label: const Text("Password"),
                      labelStyle: const TextStyle(color: Colors.black38),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black87),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _obscurepassword = !_obscurepassword;
                        },
                        icon: Icon(
                          _obscurepassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is empty";
                      }
                      if (value.length < 6) {
                        return "Password length is less than 6";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserInfoScreen()));
                      }
                    },
                    child: MaterialButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_fomKey.currentState!.validate()) {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          try {
                            context.read<AuthBloc>().add(AuthSigninWithEmail(
                                email: email, password: password));
                          } catch (e) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            });
                          }
                        }
                      },
                      elevation: 6,
                      minWidth: double.infinity,
                      color: Colors.amber,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserInfoScreen()));
                      }
                    },
                    child: MaterialButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_fomKey.currentState!.validate()) {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          try {
                            context.read<AuthBloc>().add(AuthCreateAccount(
                                email: email, password: password));
                          } catch (e) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            });
                          }
                        }
                      },
                      elevation: 6,
                      minWidth: double.infinity,
                      color: Colors.amber,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("Or"),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserInfoScreen()));
                      }
                    },
                    builder: (context, state) {
                      return SignInButton(
                        Buttons.google,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthSignin());
                        },
                      );
                    },
                  )
                ],
              ),
            )));
  }
}

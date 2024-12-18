import 'package:firebase_project/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User info"),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignOutSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
            final auth = state.authModel;
            return Center(
              child: Column(
                children: [
                  if (auth.photoURL != null)

                    // Display the image here
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: Image.network(auth.photoURL!).image,
                    ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Display name
                  Text(auth.email!),
                  const SizedBox(
                    height: 20,
                  ),

                  // Display phone number
                  Text(auth.phoneNumber ?? "Nil"),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      // Sign out
                      context.read<AuthBloc>().add(AuthSignOut());
                    },
                    child: const Text("Sign Out"),
                  ),
                ],
              ),
            );
          }
          return Text("Loading");
        },
      ),
    );
  }
}

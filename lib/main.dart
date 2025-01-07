import 'package:firebase_project/package/firebase/firebase_firestore_service.dart';
import 'package:firebase_project/package/firebase/firebase_notification_service.dart';
import 'package:firebase_project/presentation/bloc/auth/auth_bloc.dart';
import 'package:firebase_project/presentation/bloc/person/person_bloc.dart';

import 'package:firebase_project/presentation/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injections/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseFirestoreService().initialize();
  await FirebaseNotificationService().initializeNotification();

  di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: di.getIt<PersonBloc>(),
        ),
        BlocProvider.value(
          value: di.getIt<AuthBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

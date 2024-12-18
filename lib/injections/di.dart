import 'package:firebase_project/data/auth/auth_repository_impl/auth_repository_impl.dart';
import 'package:firebase_project/data/person/person_repository_impl/person_repository_impl.dart';
import 'package:firebase_project/domain/auth/auth_repository/auth_repository.dart';
import 'package:firebase_project/domain/person/person_repository/person_repository.dart';
import 'package:firebase_project/presentation/bloc/auth/auth_bloc.dart';
import 'package:firebase_project/presentation/bloc/person/person_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  // Repository
  getIt.registerSingleton<PersonRepository>(PersonRepositoryImpl());
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  //Bloc

  getIt.registerSingleton<PersonBloc>(PersonBloc(getIt<PersonRepository>()));
  getIt.registerSingleton<AuthBloc>(AuthBloc(getIt<AuthRepository>()));
}

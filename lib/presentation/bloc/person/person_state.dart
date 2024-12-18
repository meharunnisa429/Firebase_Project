part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PersonInitial extends PersonState {}

final class PersonLoading extends PersonState {}

final class PersonLoaded extends PersonState {
  final List<PersonModel> personList;
  final bool isError;
  final String message;
  final bool isLoading;

  PersonLoaded(
      {required this.personList,
      this.isError = false,
      this.message = "",
      this.isLoading = false});
  @override
  List<Object?> get props => [personList, isError, message, isLoading];

  PersonLoaded copyWith(
      {List<PersonModel>? personList,
      bool? isError,
      String? message,
      bool? isLoading}) {
    return PersonLoaded(
        personList: personList ?? this.personList,
        isError: isError ?? this.isError,
        message: message ?? this.message,
        isLoading: isLoading ?? this.isLoading);
  }
}

final class PersonError extends PersonState {}

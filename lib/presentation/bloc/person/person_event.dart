part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PersonGetAll extends PersonEvent {}

class PersonAddNew extends PersonEvent {
  final PersonModel person;
  PersonAddNew(this.person);
  @override
  List<Object?> get props => [person];
}

class PersonEdit extends PersonEvent {
  final PersonModel personToEdit;
  final int index;

  PersonEdit({required this.index, required this.personToEdit});
  @override
  List<Object?> get props => [personToEdit];
}

class PersonDelete extends PersonEvent {
  final String id;

  PersonDelete({required this.id});
  List<Object?> get props => [id];
}

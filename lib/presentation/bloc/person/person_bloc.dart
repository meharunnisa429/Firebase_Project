import 'package:firebase_project/domain/person/person_repository/person_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_project/domain/person/person_model/person_model.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository personRepository;
  PersonBloc(this.personRepository) : super(PersonInitial()) {
    on<PersonGetAll>(_getAll);
    on<PersonAddNew>(_addNew);
    on<PersonEdit>(_edit);
    on<PersonDelete>(_delete);
  }
  void _getAll(PersonGetAll event, Emitter<PersonState> emit) async {
    emit(PersonLoading());
    // try {
    List<PersonModel> personList = await personRepository.getAllPerson();
    emit(PersonLoaded(personList: personList));
    // } catch (e) {
    //   emit(PersonError());
    // }
  }

  void _addNew(PersonAddNew event, Emitter<PersonState> emit) async {
    final currentState = state;

    if (currentState is PersonLoaded) {
      emit(currentState.copyWith(isLoading: true));
      try {
        personRepository.addPerson(event.person);
        emit(currentState.copyWith(
            personList: List.from(currentState.personList)..add(event.person),
            isLoading: false));
      } catch (e) {
        emit(currentState.copyWith(
          personList: List.from(currentState.personList),
          isError: true,
          isLoading: false,
          message: e.toString(),
        ));
      }
    }
  }

  void _edit(PersonEdit event, Emitter<PersonState> emit) async {
    final currentState = state;

    if (currentState is PersonLoaded) {
      emit(currentState.copyWith(isLoading: true));
      try {
        personRepository.updatePerson(event.personToEdit);
        emit(currentState.copyWith(
            personList: List.from(currentState.personList)
              ..removeWhere(
                (element) {
                  return element.id == event.personToEdit.id;
                },
              )
              ..insert(event.index, event.personToEdit),
            isLoading: false));
      } catch (e) {
        emit(currentState.copyWith(
          personList: List.from(currentState.personList),
          isError: true,
          isLoading: false,
          message: e.toString(),
        ));
      }
    }
  }

  void _delete(PersonDelete event, Emitter<PersonState> emit) async {
    final currentState = state;

    if (currentState is PersonLoaded) {
      emit(currentState.copyWith(isLoading: true));
      try {
        personRepository.deletePerson(event.id);
        emit(currentState.copyWith(
            personList: List.from(currentState.personList)
              ..removeWhere(
                (element) {
                  return element.id == event.id;
                },
              ),
            isLoading: false));
      } catch (e) {
        emit(currentState.copyWith(
          personList: List.from(currentState.personList),
          isError: true,
          isLoading: false,
          message: e.toString(),
        ));
      }
    }
  }
}

import 'package:firebase_project/domain/person/person_model/person_model.dart';

abstract class PersonRepository {
  Future<List<PersonModel>> getAllPerson();
  void addPerson(PersonModel person);
  void updatePerson(PersonModel personToUpdate);
  void deletePerson(String id);
}

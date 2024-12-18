import 'package:firebase_project/domain/person/person_model/person_model.dart';
import 'package:firebase_project/domain/person/person_repository/person_repository.dart';
import 'package:firebase_project/package/firebase/firebase_firestore_service.dart';

class PersonRepositoryImpl extends PersonRepository {
  @override
  void addPerson(PersonModel person) {
    FirebaseFirestoreService().addPersonData(person);
  }

  @override
  void deletePerson(String id) {
    FirebaseFirestoreService().deletePerson(id);
  }

  @override
  void updatePerson(PersonModel personToUpdate) {
    FirebaseFirestoreService().updatePerson(personToUpdate);
  }

  @override
  Future<List<PersonModel>> getAllPerson() async {
    return await FirebaseFirestoreService().getPersonData();
  }
}

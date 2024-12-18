import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/data/person/person_dto.dart/person_dto.dart';
import 'package:firebase_project/domain/person/person_model/person_model.dart';
import 'package:firebase_project/firebase_options.dart';
import 'package:uuid/uuid.dart';

class FirebaseFirestoreService {
  FirebaseFirestoreService._();

  static final _instance = FirebaseFirestoreService._();

  factory FirebaseFirestoreService() => _instance;

  static late final FirebaseFirestore fdb;
  String collectionName = "PersonData";
  late final Stream<QuerySnapshot<Map<String, dynamic>>> personStream;

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // set settings
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true);
    // firestore database initializing
    fdb = FirebaseFirestore.instance;
    personStream = fdb.collection(collectionName).snapshots();
  }

  void addPersonData(PersonModel person) async {
    String uniqueId = const Uuid().v4();

    final docRef = fdb.collection(collectionName).doc(uniqueId);
    await docRef
        .set(PersonDto.fromModel(person..id = uniqueId).toJson())
        .onError((e, stack) {
      log(e.toString(), name: "Error in add");
    });
  }

  Future<List<PersonModel>> getPersonData() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapShot =
        await fdb.collection(collectionName).get();
    return querySnapShot.docs
        .map((e) => PersonDto.fromJson(e.data()).toModel())
        .toList();
  }

  void updatePerson(PersonModel personToUpdate) async {
    final DocumentReference<Map<String, dynamic>> documentRef =
        fdb.collection(collectionName).doc(personToUpdate.id);
    await documentRef
        .update(PersonDto.fromModel(personToUpdate).toJson())
        .then((value) {
      log("Updated successfully");
    }).onError((e, stack) {
      log(e.toString(), name: "Error in Edit");
    });
  }

  void deletePerson(String id) async {
    await fdb.collection(collectionName).doc(id).delete().onError((e, stack) {
      log(e.toString(), name: "Error in Delete");
    });
  }
}

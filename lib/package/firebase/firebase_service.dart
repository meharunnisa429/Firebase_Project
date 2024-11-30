import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/domain/model/person_model.dart';
import 'package:firebase_project/firebase_options.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  FirebaseService._();

  static final _instance = FirebaseService._();

  factory FirebaseService() => _instance;

  static late final FirebaseFirestore fdb;
  String collectionName = "PersonData";
  late final Stream<QuerySnapshot<Map<String, dynamic>>> personStream;
  ValueNotifier<List<PersonModel>> personList = ValueNotifier([]);

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
    await fdb
        .collection(collectionName)
        .add(person.toJson())
        .then((DocumentReference<Map<String, dynamic>> docRef) {
      final String id = docRef.id;
      log("Insert Data with $id");
    });
    // getAllPersonList();
  }

  void getAllPersonList() async {
    personList.value.clear();
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await fdb.collection(collectionName).get();
    querySnapshot.docs.map((element) {
      final String id = element.id;
      final Map<String, dynamic> data = element.data();
      personList.value.add(PersonModel.fromJson(data, id));
    });

    personList.notifyListeners();
  }

  void updatePerson(PersonModel personToUpdate) async {
    final DocumentReference<Map<String, dynamic>> documentRef =
        fdb.collection(collectionName).doc(personToUpdate.id);
    await documentRef.update(personToUpdate.toJson()).then((value) {
      log("Updated successfully");
    }).onError((e, stack) {
      log("Error is $e", name: "oxdo");
    });
    // getAllPersonList();
  }

  void deletePerson(String id) async {
    await fdb.collection(collectionName).doc(id).delete();
    // getAllPersonList();
  }
}

import 'package:firebase_project/domain/model/person_model.dart';
import 'package:firebase_project/model/save_button_mode.dart';
import 'package:firebase_project/package/firebase/firebase_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _ageFocus = FocusNode();
  SaveButtonMode _saveButtonMode = SaveButtonMode.save;
  // Only for updating
  PersonModel? _personToUpdate;
  // un focus text fields,  hide keyboard
  void _unFocusAllFocusNode() {
    _nameFocusNode.unfocus();
    _ageFocus.unfocus();
  }

  _clearControllers() {
    _nameController.clear();
    _ageController.clear();
  }

  void _bringPersonToUpdate(PersonModel person) {
    _nameController.text = person.name;
    _ageController.text = person.age.toString();
    _saveButtonMode = SaveButtonMode.edit;
    _personToUpdate = person;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _nameFocusNode.dispose();
    _ageFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Firestore"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Name"),
                hintText: "Enter name",
                hintStyle: TextStyle(color: Colors.black38),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _ageController,
              focusNode: _ageFocus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Age"),
                hintText: "Enter age",
                hintStyle: TextStyle(color: Colors.black38),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 8,
            ),

            // save or edit buttton
            ElevatedButton(
              onPressed: () {
                if (_saveButtonMode == SaveButtonMode.save) {
                  final personToSave = PersonModel(
                    name: _nameController.text.trim(),
                    age: int.tryParse(_ageController.text.trim()) ?? 0,
                  );
                  FirebaseService().addPersonData(personToSave);
                  _clearControllers();
                } else {
                  final personToUpdate = PersonModel(
                    id: _personToUpdate?.id,
                    name: _nameController.text.trim(),
                    age: int.tryParse(_ageController.text.trim()) ?? 0,
                  );
                  FirebaseService().updatePerson(personToUpdate);
                }

                _unFocusAllFocusNode();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text("Save"),
            ),
            const SizedBox(
              height: 8,
            ),

            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: personList,
                  builder: (BuildContext context, List<PersonModel> personModel,
                      Widget? _) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final person = personModel[index];
                        return Card(
                          child: ListTile(
                            title: Text("Name:- ${person.name}"),
                            subtitle: Text("Age:-${person.age} "),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _bringPersonToUpdate(person);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    FirebaseService()
                                        .deletePerson(person.id.toString());
                                  },
                                  color: Colors.red,
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: personModel.length,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

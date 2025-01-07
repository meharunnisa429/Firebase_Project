import 'dart:developer';
import 'package:firebase_project/domain/person/person_model/person_model.dart';
import 'package:firebase_project/model/save_button_mode.dart';
import 'package:firebase_project/presentation/bloc/person/person_bloc.dart';
import 'package:firebase_project/presentation/screen/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final int indexToUpdate;
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
  void initState() {
    context.read<PersonBloc>().add(PersonGetAll());
    // TODO: implement initState
    _nameController = TextEditingController();
    _ageController = TextEditingController();

    super.initState();
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              icon: Icon(Icons.notification_add))
        ],
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

            // save or edit button
            ElevatedButton(
              onPressed: () {
                if (_saveButtonMode == SaveButtonMode.save) {
                  final personToSave = PersonModel(
                    name: _nameController.text.trim(),
                    age: int.tryParse(_ageController.text.trim()) ?? 0,
                  );
                  context.read<PersonBloc>().add(PersonAddNew(personToSave));
                  _clearControllers();
                } else {
                  final personToUpdate = PersonModel(
                    id: _personToUpdate!.id,
                    name: _nameController.text.trim(),
                    age: int.tryParse(_ageController.text.trim()) ?? 0,
                  );
                  context.read<PersonBloc>().add(PersonEdit(
                        index: indexToUpdate,
                        personToEdit: personToUpdate,
                      ));
                  _clearControllers();
                }

                _unFocusAllFocusNode();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _saveButtonMode == SaveButtonMode.save
                    ? Colors.green
                    : Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text(
                  _saveButtonMode == SaveButtonMode.save ? "Save" : "Update"),
            ),
            const SizedBox(
              height: 8,
            ),
            // save or edit buttton

            const SizedBox(
              height: 8,
            ),
            BlocBuilder<PersonBloc, PersonState>(
              builder: (context, state) {
                log(state.toString(), name: "state of get all");
                if (state is PersonLoaded) {
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final person = state.personList[index];

                        return Card(
                          child: ListTile(
                            title: Text("Name:- ${person.name}"),
                            subtitle: Text("Age:- ${person.age}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // take data to update
                                    _bringPersonToUpdate(person);
                                    indexToUpdate = index;
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<PersonBloc>()
                                        .add(PersonDelete(id: person.id));
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
                      itemCount: state.personList.length,
                    ),
                  );
                }
                return const Text("No Person Yet");
              },
            )
          ],
        ),
      ),
    );
  }
}

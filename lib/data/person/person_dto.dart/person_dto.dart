import 'package:firebase_project/domain/person/person_model/person_model.dart';

class PersonDto {
  String id;
  final String name;
  final int age;

  PersonDto({this.id = "", required this.name, required this.age});

  factory PersonDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return PersonDto(
        id: json["id"] as String,
        name: json["name"] as String,
        age: json["age"] as int);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "age": age};
  }

  @override
  String toString() {
    return "id: $id, name: $name,  age: $age";
  }

  PersonModel toModel() => PersonModel(name: name, age: age);
  factory PersonDto.fromModel(PersonModel model) {
    return PersonDto(id: model.id, name: model.name, age: model.age);
  }
}

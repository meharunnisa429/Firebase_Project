class PersonModel {
  String? id;
  final String name;
  final int age;

  PersonModel({this.id, required this.name, required this.age});

  factory PersonModel.fromJson(Map<String, dynamic> json, String id) {
    return PersonModel(
        id: id, 
        name: json["name"] as String, 
        age: json["age"] as int);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "age": age};
  }

  @override
  String toString() {
    return "id: $id, name: $name,  age: $age";
  }
}

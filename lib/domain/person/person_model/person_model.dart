class PersonModel {
  String id;
  final String name;
  final int age;

  PersonModel({this.id = "", required this.name, required this.age});

  @override
  String toString() {
    return "id: $id, name: $name,  age: $age";
  }
}

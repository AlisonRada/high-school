

class Person {
  final int id;
  final String name;
  final String username;
  final String email;

  Person({this.id, this.name, this.username, this.email});

  Person.initial()
      : id = 0,
        name = '',
        username = '',
        email = '';

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}
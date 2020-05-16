
class PersonDetail {
  final int course_id;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String city;
  final String country;
  final String birthday;

  PersonDetail({this.course_id, this.name, this.username, this.phone, this.email, this.city, this.country, this.birthday});

  PersonDetail.initial()
      : course_id = 0,
        name = '',
        username = '',
        phone = '',
        email = '',
        city = '',
        country = '',
        birthday = '';

  factory PersonDetail.fromJson(Map<String, dynamic> json) {
    return PersonDetail(
        course_id: json['course_id'],
        name: json['name'],
        username: json['username'],
        phone: json['phone'],
        email: json['email'],
        city: json['city'],
        country: json['country'],
        birthday: json['birthday']
    );
  }
}
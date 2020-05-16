import 'package:f_202010_provider_get_it/architecture_example/models/person.dart';

import '../locator.dart';
import '../models/person.dart';
import 'api.dart';

class TeacherService {
  Api _api = locator<Api>();

  String _user;
  String _token;
  List<Person> _teachers = [];
  List<Person> get teachers => _teachers;

  Future getTeachers(String username, String token) async {
    _user = username;
    _token = token;
    try {
      _teachers = await _api.getTeachers(username, token);
    } catch (err) {
      print('service getStudents ${err.toString()}');
      return Future.error(err.toString());
    }
  }

}

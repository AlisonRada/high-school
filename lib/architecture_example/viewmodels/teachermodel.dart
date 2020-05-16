
import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/person.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/teachers_service.dart';

import '../locator.dart';
import '../models/person.dart';

class TeacherModel extends BaseModel {
  TeacherService _teacherService = locator<TeacherService>();

  List<Person> get teachers => _teacherService.teachers;
  bool dataAvailable = true;

  Future getTeachers(String user, String token) async {
    setState(ViewState.Busy);
    try {
      await _teacherService.getTeachers(user, token);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      print('teachermodel getCourses ${err.toString()}');
      setState(ViewState.Idle);
      return Future.error(err.toString());
    }

  }
}
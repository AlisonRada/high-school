
import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/person.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/students_service.dart';

import '../locator.dart';
import '../models/person.dart';

class StudentModel extends BaseModel {
  StudentService _studentService = locator<StudentService>();

  List<Person> get students => _studentService.students;
  bool dataAvailable = true;

  Future getStudents(String user, String token) async {
    setState(ViewState.Busy);
    try {
      await _studentService.getStudents(user, token);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      print('studentmodel getCourses ${err.toString()}');
      setState(ViewState.Idle);
      return Future.error(err.toString());
    }

  }

  Future addStudent(int courseId) async {
    setState(ViewState.Busy);
    try {
      Person student = await _studentService.addStudent(courseId);
      setState(ViewState.Idle);
      return Future.value(student);
    } catch (err) {
      print('studentmodel addStudent ${err.toString()}');
      setState(ViewState.Idle);
      return Future.error(err.toString());
    }
  }
}
import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/person_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/api.dart';

import '../locator.dart';

class PersonDetailModel extends BaseModel {
  Api _api = locator<Api>();

  PersonDetail studentDetail;

  Future getStudent(
      String user, String token, int courseId) async {
    setState(ViewState.Busy);
    studentDetail = await _api.getStudent(user, token, courseId);
    setState(ViewState.Idle);
  }

  Future getTeacher(
      String user, String token, int courseId) async {
    setState(ViewState.Busy);
    studentDetail = await _api.getTeacher(user, token, courseId);
    setState(ViewState.Idle);
  }
}

import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/user.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/authentication_service.dart';

import '../locator.dart';

class SignUpModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  User get user => _authenticationService.user;

  Future<bool> singUp(String email,String password,String username,String name) async {
    setState(ViewState.Busy);
    var success = await _authenticationService.signUp(email,password,username,name);
    notifyListeners();
    setState(ViewState.Idle);
    return success;
  }
}
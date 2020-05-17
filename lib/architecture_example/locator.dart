import 'package:f_202010_provider_get_it/architecture_example/viewmodels/signupmodel.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/studentmodel.dart';
import 'package:get_it/get_it.dart';

import 'services/api.dart';
import 'services/authentication_service.dart';
import 'services/courses_service.dart';
import 'services/students_service.dart';
import 'services/teachers_service.dart';
import 'viewmodels/coursedetailmodel.dart';
import 'viewmodels/persondetailmodel.dart';
import 'viewmodels/homemodel.dart';
import 'viewmodels/studentmodel.dart';
import 'viewmodels/loginmodel.dart';
import 'viewmodels/signupmodel.dart';
import 'viewmodels/teachermodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() =>   CourseService());
  locator.registerLazySingleton(() =>   StudentService());
  locator.registerLazySingleton(() =>   TeacherService());
  locator.registerLazySingleton(() => Api());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => SignUpModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(()=>StudentModel());
  locator.registerFactory(()=>TeacherModel());
  locator.registerFactory(()=>PersonDetailModel());
  locator.registerFactory(() => CourseDetailModel());
}

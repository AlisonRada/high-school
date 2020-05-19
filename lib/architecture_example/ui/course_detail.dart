import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/coursedetailmodel.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/students_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/course_detail.dart';
import 'login_view.dart';
import 'teachers_list.dart';

class CourseDetailView extends StatelessWidget {
  final Course course;
  CourseDetailView({this.course});
  @override
  Widget build(BuildContext context) {
    return BaseView<CourseDetailModel>(
        onModelReady: (model) => model.getCourse(
            Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token,course.id).catchError(
                (error) async {
                  print("getTeachers got error: " + error);
                  await _buildDialog(context, 'Alert', 'Need to login');
                  Provider.of<AuthProvider>(context, listen: false).setLogOut();
                }),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Course detail"),
              backgroundColor: Color.fromRGBO(140, 0, 75, 1),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(30),
                          child: Center(
                              child: Text('${model.courseDetail.name}')
                          )
                      ),
                      Center(
                        child: Row(
                          children: <Widget>[
                            MaterialButton(
                                minWidth: MediaQuery.of(context).size.width/8,
                                child: Text('Estudiantes'),
                                onPressed: (){
                                  getStudentsList(context, course, model.courseDetail);
                                }),
                            Spacer(
                            ),
                            MaterialButton(
                                minWidth: MediaQuery.of(context).size.width/8,
                                child: Text('Profesores'),
                                onPressed: (){
                                  getTeachersList(context, course, model.courseDetail);
                                })
                          ],
                        ),
                      )
                    ],
                  ))));
  }

  void getStudentsList(BuildContext context, Course course, CourseDetail courseDetail) async {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => StudentListView(course: course, courseDetail: courseDetail)),
    );
  }

  void getTeachersList(BuildContext context, Course course, CourseDetail courseDetail) async {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => TeacherListView(course: course, courseDetail: courseDetail)),
    );
  }
  Future<void> _buildDialog(BuildContext context, _title, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      LoginView()), (Route<dynamic> route) => false);
                })
          ],
        );
      },
      context: context,
    );
  }
}

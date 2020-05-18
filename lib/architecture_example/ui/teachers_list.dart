import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/person_detail_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/studentmodel.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/teachermodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/course_detail.dart';
import '../models/person.dart';
import 'home_view.dart';
import 'login_view.dart';
import 'students_list.dart';

class TeacherListView extends StatelessWidget {
  final Course course;
  final CourseDetail courseDetail;
  TeacherListView({this.course, this.courseDetail});

  @override
  Widget build(BuildContext context) {
    return BaseView<TeacherModel>(
        onModelReady: (model) => getData(context, model),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Lista de profesores"),
            backgroundColor: Color.fromRGBO(140, 0, 75, 1),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children:  <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(140, 0, 75, 1),
                  ),
                  child: Text(
                    'Camp half blood',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.class_),
                  title: Text('Cursos'),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => CourseListView()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Estudiantes'),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => StudentListView()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Cerrar sesión'),
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        LoginView()), (Route<dynamic> route) => false);
                  },
                )
              ],
            ),
          ),
          body: course == null ? model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
              itemCount: model.teachers.length,
              itemBuilder: (context, index) {;
              var student = model.teachers[index];
              return _item(student, context);
              }) : ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {;
              var teacher = courseDetail.professor;
              return _item(teacher, context);
              }),
        ));
  }

  void getData(BuildContext context, TeacherModel model) async {
    model.getTeachers(Provider.of<AuthProvider>(context).username,
        Provider.of<AuthProvider>(context).token)
        .catchError((error) async {
      print("getTeachers got error: " + error);
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();

    });
  }

  void getDetail(BuildContext context, int teacherId) async {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => StudentDetailView(studentId: teacherId, isStudent: false)),
    );
  }

  Widget _item(Person student, BuildContext context) {
    return Dismissible(key: UniqueKey(),
      background: Container(color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child:
          Text("Deleting",
              style: TextStyle(fontSize: 15, color: Colors.white)
          ),
        ),
      ),
      child: Container(
        padding: new EdgeInsets.all(7.0),
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: ListTile(
              leading: Icon(Icons.perm_identity, size: 45.0),
              title: Text(student.name.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(student.name),
              isThreeLine: true,
              onTap: ()=>getDetail(context, student.id),
            ),
          ),
        ),
      ),
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
                  /*Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);*/
                })
          ],
        );
      },
      context: context,
    );
  }

}

import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/course_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/students_list.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/teachers_list.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/homemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';

class CourseListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        onModelReady: (model) => getData(context, model),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Lista de cursos"),
              backgroundColor: Color.fromRGBO(140, 0, 75, 1),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .setLogOut();
                  },
                ),
              ],
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
                  leading: Icon(Icons.perm_identity),
                  title: Text('Profesores'),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => TeacherListView()),
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

              ],
            ),
          ),
            floatingActionButton: floating(context, model),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: model.courses.length,
              itemBuilder: (context, index) {
                var course = model.courses[index];
                return _item(course, context);
              },
            ),
        ));
  }

  void getData(BuildContext context, HomeModel model) async {
    model.getCourses(Provider.of<AuthProvider>(context).username,
        Provider.of<AuthProvider>(context).token)
        .catchError((error) async {
          print("getCourses got error: " + error);
          await _buildDialog(context, 'Alert', 'Need to login');
          Provider.of<AuthProvider>(context, listen: false).setLogOut();
    });
  }

  void getDetail(BuildContext context, Course course) async {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CourseDetailView(course: course)),
    );
  }

  Widget _item(Course course, BuildContext context) {
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
              leading: Icon(Icons.class_, size: 45.0),
              title: Text(course.id.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(course.name),
              isThreeLine: true,
              onTap: ()=>getDetail(context, course),
            ),
          ),
        ),
      ),
    );
  }

  Widget floating(BuildContext context, HomeModel model) {
    return FloatingActionButton(
        backgroundColor: Color.fromRGBO(140, 0, 75, 1),
        onPressed: () => _onAdd(context, model),
        tooltip: 'Add course',
        child: new Icon(Icons.add));
  }

  void _onAdd(BuildContext context, HomeModel model) async {
    try {
      await model.addCourse();
    } catch (err) {
      print('upsss ${err.toString()}');
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
    }
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
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}

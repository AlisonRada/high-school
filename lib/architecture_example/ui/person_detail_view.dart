import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/persondetailmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetailView extends StatelessWidget {
  final bool isStudent;
  final int studentId;
  StudentDetailView({this.studentId, this.isStudent});
  @override
  Widget build(BuildContext context) {
    return BaseView<PersonDetailModel>(
        onModelReady: (model) => isStudent ? model.getStudent(
            Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token,studentId) :
            model.getTeacher(
            Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token,studentId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Información detallada"),
              backgroundColor: Color.fromRGBO(140, 0, 75, 1),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: <Widget>[
                        Text('Curso ID: ${model.studentDetail.course_id}'),
                        Text('Nombre: ${model.studentDetail.name}'),
                        Text('Username: ${model.studentDetail.username}'),
                        Text('Cumpleaños: ${model.studentDetail.birthday}'),
                        Text('País: ${model.studentDetail.country}'),
                        Text('Ciudad: ${model.studentDetail.city}'),
                        Text('Email: ${model.studentDetail.email}'),
                        Text('Celular: ${model.studentDetail.phone}'),
                      ],
                    )
                )
              ],
            )));
  }
}

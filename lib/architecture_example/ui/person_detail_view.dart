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
                        SizedBox(height: MediaQuery.of(context).size.height/30,),
                        Icon(Icons.account_circle,
                          size: 150.0,
                          color: Color.fromRGBO(140, 0, 75, 1).withOpacity(0.9),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        child: Text(model.studentDetail.name,
                          style: TextStyle(fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(140, 0, 75, 1).withOpacity(0.9),
                            fontSize: 17.0,)
                          ,)
                        ),
                        Padding(padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 50,),
                            Text('Curso ID: ${model.studentDetail.course_id}',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                fontSize: 15.0,),
                            ),
                            SizedBox(width: 30,),
                            Text('Usuario: ${model.studentDetail.username}',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                fontSize: 15.0,),
                            ),
                          ],
                        ),
                        ),Padding(padding: const EdgeInsets.all(6.0),
                            child:Text('Cumpleaños: ${model.studentDetail.birthday.substring(0,10)}',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                fontSize: 15.0,),
                            )
                        ),
                        Padding(padding: const EdgeInsets.all(6.0),
                        child:Text('Ciudad: ${model.studentDetail.city}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            fontSize: 15.0,),
                        ),
                        ),
                        Padding(padding: const EdgeInsets.all(6.0),
                          child:Text('País: ${model.studentDetail.country}',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 15.0,),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(6.0),
                          child:Text('Correo: ${model.studentDetail.email}',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 15.0,),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(6),
                        child: Text('Celular: ${model.studentDetail.phone}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            fontSize: 15.0,),
                        ),
                        ),
                      ],
                    )
                )
              ],
            )));
  }
}

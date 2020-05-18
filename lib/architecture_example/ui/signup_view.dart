import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/signupmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {

  Color colorApp = Color.fromRGBO(140, 0, 75, 1);

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    String email, password, usuario, nombre;
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    RegExp emailRegExp =
    new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');

    RegExp contRegExp = new RegExp(r'^([1-z0-1@A-Z.\s]{1,255})$');
    RegExp contNumExp = new RegExp('[a-zA-Z]');

    return BaseView<SignUpModel>(
        builder: (context, model, child) => Scaffold(
            body:
            // Provider.of<User>(context, listen: false).logged == true ?  CourseListView() :
            model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
              child: Center(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("SingUp"),
                    backgroundColor: colorApp,
                  ),
                  body: ListView(
                    children: <Widget>[
                      Icon(Icons.school,
                        size: 150.0,
                        color: Color.fromRGBO(140, 0, 75, 1),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    usuario = value;
                                    return null;
                                  },
                                  style: style,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      labelText: 'Username',
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    nombre = value;
                                    return null;
                                  },
                                  style: style,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      labelText: 'Nombre',
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return "Este campo correo es requerido";
                                    } else if (!emailRegExp.hasMatch(text)) {
                                      return "El formato para correo no es correcto";
                                    }
                                    email = text;
                                    return null;
                                  },
                                  style: style,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      labelText: 'Email',
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      //hintText: "Email",
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    password = value;
                                    return null;
                                  },
                                  style: style,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      labelText: 'Contraseña',
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)))
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      var loginSuccess = await model
                                          .singUp(email, password,usuario,nombre);
                                      if (loginSuccess) {
                                        print(
                                            'LoginView loginSuccess setting up setLoggedIn ');
                                        Provider.of<AuthProvider>(context,
                                            listen: false)
                                            .setLoggedIn(
                                            model.user.username,
                                            model.user.token);
                                      }
                                    }
                                  },
                                  color: colorApp,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)
                                  ),
                                  elevation: 3.0,
                                  child: Text('Create user',
                                      style: style.copyWith(
                                          color: Colors.white, fontWeight: FontWeight.bold)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ),
            )));
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
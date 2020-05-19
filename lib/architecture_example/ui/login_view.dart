import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/loginmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodels/loginmodel.dart';
import 'home_view.dart';
import 'signup_view.dart';
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Color colorApp = Color.fromRGBO(140, 0, 75, 1);

  String email, password;
  var _rememberMe=false;
  //String initEmail, initPassword;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  RegExp emailRegExp =
  new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');

  RegExp contRegExp = new RegExp(r'^([1-z0-1@A-Z.\s]{1,255})$');
  RegExp contNumExp = new RegExp('[a-zA-Z]');

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // load data on startup
    _getCredencials();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        builder: (context, model, child) => Scaffold(
            body:
            // Provider.of<User>(context, listen: false).logged == true ?  CourseListView() :
            model.state == ViewState.Busy ? Center(child: CircularProgressIndicator())
                : Center(
              child: Center(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("Login"),
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
                                  controller: emailController,
                                  //initialValue: initEmail,//getEmailR(context),
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
                                  controller: passwordController,
                                  //initialValue: initPassword,//getPasswordR(context),
                                  validator: (text) {
                                    if (text.length == 0) {
                                      return "Este campo contraseña es requerido";
                                    } else if (text.length < 8) {
                                      return "Su contraseña debe ser al menos de 5 caracteres";
                                    } else if (!contRegExp.hasMatch(text)) {
                                      return "El formato para contraseña no es correcto";
                                    }
                                    password = text;
                                    return null;
                                  },
                                  style: style,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      hintText: "Password",
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
                                      var loginSuccess=await model.login(email, password)??false;
                                      if (loginSuccess) {
                                        var prov = Provider.of<AuthProvider>(context, listen: false);
                                        _setCredencials();
                                        print(
                                            'LoginView loginSuccess setting up setLoggedIn ');
                                        prov.setLoggedIn(
                                            model.user.username,
                                            model.user.token);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => CourseListView()),
                                        );
                                      }
                                    }
                                  },
                                  color: colorApp,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)
                                  ),
                                  elevation: 3.0,
                                  child: Text('LogIn',
                                      style: style.copyWith(
                                          color: Colors.white, fontWeight: FontWeight.bold)
                                  ),
                                ),
                              ),
                            ),
                            Center(
                                child: Row(
                                  children: <Widget>[
                                    Switch(
                                      value: _rememberMe,
                                      onChanged:_onRememberMeChanged,
                                      activeTrackColor: Colors.black38,
                                      activeColor: Color.fromRGBO(140, 0, 75, 1),
                                    ),
                                    Text(
                                      'Remember me',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    Spacer(),
                                    FlatButton(
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => SignUpView()));
                                          },
                                          child: Text(
                                            'SignUp',
                                            textAlign: TextAlign.end,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }

  void _onRememberMeChanged(bool newValue) => _rememberMe = newValue;

// Get user data after login
  _getCredencials() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('remember')!=null && prefs.getBool('remember')){
      emailController.text=prefs.getString('emailR');
      passwordController.text=prefs.getString('passwordR');
      setState((){_rememberMe=true;});
    }else{
      emailController.clear();
      passwordController.clear();
    }
  }
  _setCredencials() async {
    final prefs = await SharedPreferences.getInstance();
    if(_rememberMe){
      prefs.setBool('remember', true);
      prefs.setString('emailR', emailController.text);
      prefs.setString('passwordR', passwordController.text);
    }else{
      prefs.setBool('remember', false);
      prefs.remove('passwordR');
      prefs.remove('emailR');
    }
    emailController.clear();
    passwordController.clear();
  }
}

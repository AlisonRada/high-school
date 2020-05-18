import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _read();
  }
  String _username;
  String _token;
  bool _loggedIn = false;
  bool _userCreated = false;
  bool _remember = false;
  String _email, _password;

  get username => _username;
  get userCreated => _userCreated;
  get loggedIn => _loggedIn;
  get token => _token;
  get remember => _remember;
  get email => _email;
  get password => _password;




  void isRemember() async{
    final prefs = await SharedPreferences.getInstance();
    final r = prefs.getBool('remember') ?? false;
    final e = prefs.getString('emailR') ?? "_";
    final p = prefs.getString('passwordR') ?? "_";
      _remember = r;
      _email = e;
      _password = p;
    notifyListeners();
  }

  void setLoggedIn(String userName, String token) {
    _username = userName;
    _loggedIn = true;
    _token = token;
    _save();
    notifyListeners();
  }

  void setLogOut() {
    _loggedIn = false;
    _save();
    notifyListeners();
  }

  void setUserCreated(bool state) {
    _userCreated = state;
    notifyListeners();
  }
  void setRemember(rememberMe, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("remember", rememberMe);
    prefs.setString("emailR", email);
    prefs.setString("passwordR", password);
  }
  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getBool('my_int_key') ?? false;
    final t = prefs.getString('my_token') ?? "_";
    final x = prefs.getString('my_username') ?? "_";
    if (v != null) {
      _loggedIn = v;
      _token = t;
      _username = x;
      notifyListeners();
    }
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('my_int_key', _loggedIn);
    prefs.setString('my_token', _token);
    prefs.setString('my_username', _username);
  }
}


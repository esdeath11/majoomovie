import 'package:flutter/material.dart';

class AuthenProvider extends ChangeNotifier {
  AuthenProvider._();
  static final instance = AuthenProvider._();

  bool statusLogin = false;
  bool getStatusLogin() => statusLogin;

  set setStatusLogin(bool value) {
    statusLogin = value;
    notifyListeners();
  }

  String email = '';
  String getEmail() => email;

  set setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void removeAll() {
    statusLogin = false;
    email = '';
    notifyListeners();
  }
}

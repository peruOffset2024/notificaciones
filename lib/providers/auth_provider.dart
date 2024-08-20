import 'package:flutter/material.dart';

class Authprovider with ChangeNotifier {
  String _username = '';

  String get username => _username;

  void authentication(String usuario) {
    _username = usuario;
    notifyListeners();
  }
}

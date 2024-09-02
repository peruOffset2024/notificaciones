import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Authprovider with ChangeNotifier {
  String _username = '';
  String _conductor = '';
  String _ruc = '';

  bool _authenticated = false;

  String get username => _username;
  String get conductor => _conductor;
  String get ruc => _ruc;


  bool get authenticated => _authenticated;

  void authentication(String usuario) async {
    try {
      await login(usuario);
    } catch (e) {
      print('Error ; $e');
      // Mostrar un mensaje de error al usuario
    }
  }
  
  Future<void> login(String dni) async {
  try {
    final url = Uri.parse('http://190.107.181.163:81/aqnq/ajax/login.php?dni=$dni');
    final response = await http.get(url);
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Response Status: ${response.statusCode}');
      
      final responsedata = jsonDecode(response.body);
      if (responsedata['valid'] == true) {
        _username = responsedata['DNI'] ?? '';  // Asegúrate de que el campo coincida con la respuesta
        _conductor = responsedata['CONDUCTOR'] ?? '';
        _ruc = responsedata['RUC'];
        _authenticated = true;
        print('Este es el ruc ---->>: $_ruc');
        notifyListeners();
      } else {
        throw Exception(responsedata['message'] ?? 'Authentication failed');
      }
    } else {
      throw Exception('Failed to authenticate!');
    }
  } catch (e) {
    _authenticated = false;
  _username = '';
  _conductor = '';
  _ruc = '';
  print('Error ---->: $e');
  notifyListeners();
  }
}


  void logout(){
    _authenticated = false;
    _username = '';
    notifyListeners();
  }
}
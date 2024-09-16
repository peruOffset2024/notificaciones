import 'package:flutter/material.dart';

class EstadosValoresProvider with ChangeNotifier {
  String _valor1 = '1';
  String _valor2 = '2';
  String _valor3 = '3';

  String get valor1 => _valor1;
  String get valor2 => _valor2;
  String get valor3 => _valor3;

  void obtenervalor1(String valor){
      _valor1 = valor;
      notifyListeners();

  }
  void obtenervalor2(String valor){
    _valor2 = valor;
    notifyListeners();
  }
  void obtenervalor3(String valor){
    _valor3 = valor;
    notifyListeners();
  }
}
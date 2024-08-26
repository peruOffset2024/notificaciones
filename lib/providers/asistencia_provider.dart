import 'package:flutter/material.dart';

class AsistenciaProvider extends ChangeNotifier {
  final List<Map<String, String>> _asistencias = [];

  List<Map<String, String>> get asistencias => _asistencias;

  void agregarAsistencia(String nombre, String inicio, String fin, String horas) {
    _asistencias.add({
      'nombre': nombre,
      'inicio': inicio,
      'fin': fin,
      'horas': horas,
    });
    notifyListeners();
  }
}

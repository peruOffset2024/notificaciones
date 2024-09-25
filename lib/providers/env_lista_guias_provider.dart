import 'package:flutter/material.dart';

class EnviarListaGuiasProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<String> _guiasSeleccionadas = [];

  List<String> get guiasSeleccionadas => _guiasSeleccionadas;

  void agregarGuia(String guia) {
    _guiasSeleccionadas.add(guia);
     // ignore: avoid_print
    print('------> $guiasSeleccionadas ');
    notifyListeners();
  }

  void eliminarGuia(String guia) {
    _guiasSeleccionadas.remove(guia);
     // ignore: avoid_print
    print('------> $guiasSeleccionadas ');
    notifyListeners();
  }

  void limpiar() {
    _guiasSeleccionadas.clear();
    notifyListeners();
  }
}

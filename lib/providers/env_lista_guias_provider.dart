import 'package:flutter/material.dart';

class EnviarListaGuiasProvider with ChangeNotifier {
  List<String> _guiasSeleccionadas = [];

  List<String> get guiasSeleccionadas => _guiasSeleccionadas;

  void agregarGuia(String guia) {
    _guiasSeleccionadas.add(guia);
    print('------> $guiasSeleccionadas ');
    notifyListeners();
  }

  void eliminarGuia(String guia) {
    _guiasSeleccionadas.remove(guia);
    print('------> $guiasSeleccionadas ');
    notifyListeners();
  }

  void limpiar() {
    _guiasSeleccionadas.clear();
    notifyListeners();
  }
}

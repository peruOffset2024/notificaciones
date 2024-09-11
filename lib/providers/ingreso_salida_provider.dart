import 'package:flutter/foundation.dart';

class IngresoSalidaAsistencia with ChangeNotifier {
  bool _ingresoHabilitado = true;
  bool _salidaHabilitada = false;

  bool get ingresoHabilitado => _ingresoHabilitado;
  bool get salidaHabilitada => _salidaHabilitada;

  void registrarIngreso() {
    _ingresoHabilitado = false;
    _salidaHabilitada = true;
    notifyListeners();
  }

  void registrarSalida() {
    _salidaHabilitada = false;
    _ingresoHabilitado = true;
    notifyListeners();
  }
}

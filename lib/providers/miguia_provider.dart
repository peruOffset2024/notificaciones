import 'dart:math';

import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/modelo_guias.dart';

class MiGuiasProvider extends ChangeNotifier {
  List<Guias> _guias = [];
  List<Guias> _filtroguias = [];

  List<Guias> get guias => _filtroguias;

  rutasProvider() {
    _guias = List.generate(
        50,
        (index) => Guias(
              registros: index % 2 == 0
                  ? 'Salida ${index ~/ 2 + 1}'
                  : 'Llegada ${index ~/ 2 + 1}',
              horas: DateTime.now()
                  .subtract(Duration(minutes: Random().nextInt(60))),
            ));
    _filtroguias = _guias;
    print(_filtroguias);
  }

  void buscarRuta(String query) {
    if (query.isEmpty) {
      _filtroguias = _guias;
    } else {
      _filtroguias = _guias
          .where((ruta) =>
              ruta.registros.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

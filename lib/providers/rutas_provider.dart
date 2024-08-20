import 'dart:math';
import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/ruta.dart';

class RutasProvider with ChangeNotifier {
  List<Ruta> _rutas = [];
  List<Ruta> _filteredRutas = [];

  List<Ruta> get rutas => _filteredRutas;

  RutasProvider() {
    // Inicializar los datos simulados
    _rutas = List.generate(
      20,
      (index) => Ruta(
        registro: index % 2 == 0
            ? ' Salida ${index ~/ 2 + 1} \n T006-22222'
            : 'Llegada ${index ~/ 2 + 1}\n T006-22222 ',
        hora: DateTime.now()
            .subtract(Duration(minutes: Random().nextInt(60))),
      ),
    );
    _filteredRutas = _rutas;
    notifyListeners(); // Notificar a los oyentes inicialmente
  }

  void searchRuta(String query) {
    if (query.isEmpty) {
      _filteredRutas = _rutas;
    } else {
      _filteredRutas = _rutas.where((ruta) {
        final registroLower = ruta.registro.toLowerCase();
        final queryLower = query.toLowerCase();
        return registroLower.contains(queryLower);
      }).toList();
    }
    notifyListeners(); // Notificar a los oyentes después de filtrar
  }
}

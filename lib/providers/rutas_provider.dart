import 'dart:math';

import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/modelo_ruta.dart'; 


//Esta clase la uso en mi clase GuiasServicios
class RutasProvider with ChangeNotifier {
  List<Ruta> _rutas = [];
  List<Ruta> _filteredRutas = [];

  List<Ruta> get rutas => _filteredRutas; // Usamos los resultados filtrados

  RutasProvider() {
    // Inicializar los datos simulados
    _rutas = List.generate(
      50,
      (index) => Ruta(
        registro: index % 2 == 0
            ? ' \n F001-555${index ~/ 2 + 1}'
            : 'Llegada${index ~/ 2 + 1}',
        hora: DateTime.now()
            .subtract(Duration(minutes: Random().nextInt(60))),
      ),
    );
    _filteredRutas = _rutas; // Inicialmente, todos los datos están en los resultados filtrados
  }

  void searchRuta(String query) {
    if (query.isEmpty) {
      _filteredRutas = _rutas; // Si no hay búsqueda, muestra todos los datos
    } else {
      _filteredRutas = _rutas.where((ruta) {
        return ruta.registro.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners(); // Notifica a los widgets escuchando para que se reconstruyan
  }
}

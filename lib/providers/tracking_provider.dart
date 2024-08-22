import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/modelo_puntos_llegada.dart';

class TrackingProvider with ChangeNotifier {
  int _currentLocationIndex = 0;

  // Definir los puntos a lo largo de una línea vertical
  final List<LocationPoint> _locations = [
    LocationPoint(name: 'Partida', x: 100, y: 50),          // Parte superior
    LocationPoint(name: 'Llegada\nCliente', x: 100, y: 200), // Segunda posición
    LocationPoint(name: 'Salida\nCliente', x: 100, y: 350),              // Tercera posición
    LocationPoint(name: 'POD', x: 100, y: 500),      // Nuevo contenedor
  ];

  // Getter para acceder a la lista de ubicaciones
  List<LocationPoint> get locations => _locations;

  LocationPoint get currentLocation => _locations[_currentLocationIndex];

  double get progress {
    return (_currentLocationIndex + 1) / _locations.length;
  }

  void moveToNextLocation() {
    if (_currentLocationIndex < _locations.length - 1) {
      _currentLocationIndex++;  // Mover al siguiente punto
    } else {
      _currentLocationIndex = 0;  // Regresar al primer punto
    }
    notifyListeners();
  }
}



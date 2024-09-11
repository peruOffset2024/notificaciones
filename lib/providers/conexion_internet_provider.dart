import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  ConnectivityProvider() {
    // Inicializar el chequeo de conectividad al comenzar
    _checkInitialConnectivity();

    // Escuchar cambios en la conectividad
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) { 
      if (results.isNotEmpty) {
        _updateConnectionStatus(results.first);
      }
    });
  }

  // Verificar el estado inicial de conectividad
  Future<void> _checkInitialConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result as ConnectivityResult);
    } catch (e) {
      // Si hay un error, establecer el estado en 'none'
      _updateConnectionStatus(ConnectivityResult.none);
    }
  }

  // Actualizar el estado de conectividad
  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;
    notifyListeners();
  }

  // Obtener el estado actual de conectividad
  ConnectivityResult get connectionStatus => _connectionStatus;

  // Verificar si hay conexión
  bool get isConnected => _connectionStatus != ConnectivityResult.none;
}

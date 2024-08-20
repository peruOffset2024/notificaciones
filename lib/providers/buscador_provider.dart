import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/modelo_json.dart';
import 'package:http/http.dart' as http;

class BuscadorProvider with ChangeNotifier {
  List<Ubicacion> _ubicacion = [];
  bool _isLoading = false;

  List<Ubicacion> get ubicacion => _ubicacion;
  bool get isLoading => _isLoading;

  Future<void> mostrarResultados(String numero) async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=$numero'));
    if (response.statusCode == 200) {
      // Decodificamos la respuesta JSON
      final decodedData = jsonDecode(response.body);

      // Verificamos si la respuesta es una lista o un mapa
      if (decodedData is List) {
        _ubicacion = decodedData.map((item) => Ubicacion.fromJson(item)).toList();
      } else if (decodedData is Map<String, dynamic>) {
        // Si la respuesta es un objeto, puedes manejarlo según sea necesario.
        // Aquí supongo que contiene una clave 'data' que es la lista que necesitas.
        if (decodedData.containsKey('data') && decodedData['data'] is List) {
          _ubicacion = (decodedData['data'] as List)
              .map((item) => Ubicacion.fromJson(item))
              .toList();
        } else {
          // Manejo del caso en el que la estructura no es la esperada
          _ubicacion = [];
        }
      }
    } else {
      _ubicacion = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}

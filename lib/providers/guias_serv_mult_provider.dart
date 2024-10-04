import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/modelo_servicios_multiples.dart';
import 'package:http/http.dart' as http;

class GuiasServiciosMultiplesProvider with ChangeNotifier {
  List<ServiciosMultiples> _guiasServiciosMultiples = [];
  List<ServiciosMultiples> _filtroGuiaMultiples = [];
  bool _isLoading = false;

  List<ServiciosMultiples> get guiasServiciosMultiples => _filtroGuiaMultiples;
  bool get isLoading => _isLoading;

  Future<void> feachGuiasServicioMultiples(String ruc) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(
          'http://190.107.181.163:81/aqnq/ajax/lista_guias_servicio.php?ruc=$ruc'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('error')) {
          // Manejar el caso de error
          // ignore: avoid_print
          print('Error: ${data['error']}');
          _guiasServiciosMultiples = [];
          _filtroGuiaMultiples = [];
        } else if (data is List<dynamic>) {
          // Si es un alista, procesarla normalmente
          _guiasServiciosMultiples = data
              .map((servMult) => ServiciosMultiples.fromJson(servMult))
              .toList();
          _filtroGuiaMultiples =
              _guiasServiciosMultiples; // Al principio, ambas listas son iguales
          // ignore: avoid_print
          print(
              'Datos obtenidos desde la api: ---> : $_guiasServiciosMultiples');
        } else {
          // Manejar el caso de que no se obtenga un listado o un mapa
           throw Exception('NO es el formato esperado');
        }
      } else {
        throw Exception('Failed to load guias');
      }
    } catch (e) {
      throw Exception('Failed to load guias: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchMultiplesGuiasServicio(String query) {
    if (query.isEmpty) {
      _filtroGuiaMultiples = List.from(_guiasServiciosMultiples);
    } else {
      _filtroGuiaMultiples = _guiasServiciosMultiples
          .where((guiaServ) =>
              (guiaServ.guia).toLowerCase().contains(query.toLowerCase()) ||
              (guiaServ.cliente).toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Método para eliminar una guía localmente
  void eliminarGuia(String guia) {
    _guiasServiciosMultiples.removeWhere((item) => item.guia == guia);
    _filtroGuiaMultiples.removeWhere((item) => item.guia == guia);
    notifyListeners();
  }

  void eliminarVariasGuias(List<String> eliminarGuias) {
    _guiasServiciosMultiples
        .removeWhere((item) => eliminarGuias.contains(item.guia));
    _filtroGuiaMultiples
        .removeWhere((item) => eliminarGuias.contains(item.guia));
        print('guias eliminadas: $eliminarGuias');
    notifyListeners();
  }
}

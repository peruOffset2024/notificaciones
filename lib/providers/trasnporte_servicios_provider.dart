import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notificaciones/models/modelo_servicios.dart';

class TransporteServiciosProvider with ChangeNotifier {
  List<Servicios> _guiasServicio = [];
  List<Servicios> _filteredGuiaServicio = [];
  bool _isLoading = false;

  List<Servicios> get guiasServicios => _filteredGuiaServicio;
  bool get isLoading => _isLoading;

  Future<void> fechtGuiasServicios(String ruc) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(
          'http://190.107.181.163:81/aqnq/ajax/lista_guias_servicio.php?ruc=$ruc'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _guiasServicio =
            data.map((jsonServ) => Servicios.fromJson(jsonServ)).toList();
        _filteredGuiaServicio = _guiasServicio;
      } else {
        throw Exception('Failed to load guias');
      }
    } catch (e) {
      throw Exception('Failed to load guis: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchGuiaServicio(String query) {
    if (query.isEmpty) {
      _filteredGuiaServicio = List.from(_guiasServicio);
    } else {
      _filteredGuiaServicio = _guiasServicio
          .where((guia) =>
              (guia.guia).toLowerCase().contains(query.toLowerCase()) ||
              (guia.cliente).toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void eliminarGuiaServicio(String guia) {
    _guiasServicio.removeWhere((item) => item.guia == guia);
    _filteredGuiaServicio.removeWhere((guia) => guia.guia == guia);
    notifyListeners();
  }
}

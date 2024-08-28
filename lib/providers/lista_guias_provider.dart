import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notificaciones/models/modelo_lista_guias.dart';

class ListaGuiaProvider with ChangeNotifier {
  List<ListaGuias> _guia = [];
  List<ListaGuias> _filteredGuia = [];

  List<ListaGuias> get guias => _filteredGuia.isEmpty ? _guia : _filteredGuia;

  Future<void> fetchGuias() async {
    try {
      final response = await http.get(Uri.parse('http://190.107.181.163:81/aqnq/ajax/lista_guias.php'));

      if (response.statusCode == 200) {
        print('Verificar el status ${response.statusCode}');
        final data = jsonDecode(response.body) as List;
        _guia = data.map((json) => ListaGuias.fromJson(json)).toList();
        _filteredGuia = List.from(_guia); // Inicializar la lista filtrada con todos los elementos
        notifyListeners();
      } else {
        throw Exception('Failed to load guias');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load guias');
    }
  }

  void searchGuia(String query) {
    if (query.isEmpty) {
      _filteredGuia = List.from(_guia); // Resetear a la lista original
    } else {
      _filteredGuia = _guia.where((guia) => 
        (guia.guia ?? '').toLowerCase().contains(query.toLowerCase()) ||
        (guia.cliente ?? '').toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }
}

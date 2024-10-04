import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notificaciones/models/modelo_lista_guias.dart';

class ListaGuiaProvider with ChangeNotifier {
  List<ListaGuias> _guia = [];
  List<ListaGuias> _filteredGuia = [];
  bool _isLoading = false;

  List<ListaGuias> get guias => _filteredGuia;
  bool get isLoading => _isLoading;

  Future<void> fetchGuias(String ruc) async {
    _isLoading = true; 
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('http://190.107.181.163:81/aqnq/ajax/lista_guias.php?ruc=$ruc'));
      if (response.statusCode == 200) {
        final  data = jsonDecode(response.body);
        // Verificar si la respuesta contiene un mensaje de error en lugar de una lista
        if(data is Map<String, dynamic> && data.containsKey('error')) {
          // Manejar el caso de error
         // ignore: avoid_print
        print('Error: ${data['error']}');
        _guia = [];
        _filteredGuia = [];
        } else if (data is List<dynamic>){
          // Si es una lista, procesarla normalmente
          _guia = data.map((jsonItem) => ListaGuias.fromJson(jsonItem)).toList();
          _filteredGuia = _guia; // Al principio, ambas listas son iguales
           // ignore: avoid_print
        print('Datos obtenidos desde la api: ---> : $_guia'); 
        
        } else {
          // Manejar el caso de que la respuesta no sea una lista ni un mapa
          
          throw Exception('NO es el formato esperado');
        }

        
      } else {
        throw Exception('fallo al cargar las guías');
      }
    } catch (e) {
      throw Exception('fallo al cargar las guías: $e');
    }
    finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchGuia(String query) {
    if (query.isEmpty) {
      _filteredGuia = List.from(_guia); // Resetear a la lista original
    } else {
      _filteredGuia = _guia.where((guia) => 
        (guia.guia).toLowerCase().contains(query.toLowerCase()) ||
        (guia.cliente).toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  // Método para eliminar una guía localmente
  void eliminarGuia(String guia) {
    _guia.removeWhere((item) => item.guia == guia);
    _filteredGuia.removeWhere((item) => item.guia == guia);
    notifyListeners();
  }

  void eliminarVariasGuias(List<String> guiasEliminar){
    _guia.removeWhere((item) => guiasEliminar.contains(item.guia));
    _filteredGuia.removeWhere((item) => guiasEliminar.contains(item.guia));
    notifyListeners();
  }
}
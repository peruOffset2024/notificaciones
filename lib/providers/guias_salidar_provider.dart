import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notificaciones/models/modelo_api_diferencias.dart';

//Provider de la pantalla principal incluye consumo de api
class GuiasSalidasProvider with ChangeNotifier {
  List<SalidaGuia> _productos = [];
  List<SalidaGuia> _filteredProductos = [];

  // Si hay resultados filtrados, los retorna, de lo contrario devuelve una lista vacía.
  List<SalidaGuia> get productos => _filteredProductos;

  Future<void> fetchProductos(String dni, String ruc) async {
    final url = Uri.parse('http://190.107.181.163:81/aqnq/ajax/lista_salidas.php?dni=$dni&ruc=$ruc');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        _productos = jsonData.map((item) => SalidaGuia.fromJson(item)).toList();
        _filteredProductos = _productos; // Al principio, ambas listas son iguales
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
    }
  }

  void searchProducto(String query) {
    if (query.isEmpty) {
      _filteredProductos = _productos; // Si no hay texto, se muestra la lista completa
    } else {
      _filteredProductos = _productos.where((producto) {
        return producto.cliente.toLowerCase().contains(query.toLowerCase()) ||
               producto.nroGuia.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners(); // Actualizar la UI
  }
}


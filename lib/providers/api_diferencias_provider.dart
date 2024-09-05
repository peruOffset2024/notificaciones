import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notificaciones/models/modelo_api_diferencias.dart';

//Provider de la pantalla principal incluye consumo de api
class ProductosProvider with ChangeNotifier {
  List<SalidaGuia> _productos = [];
  List<SalidaGuia> _filteredProductos = [];

  List<SalidaGuia> get productos => _filteredProductos.isEmpty ? _productos : _filteredProductos;

  

  Future<void> fetchProductos(String dni, String ruc) async {
    final url = Uri.parse('http://190.107.181.163:81/aqnq/ajax/lista_salidas.php?dni=$dni&ruc=$ruc');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _productos = jsonData.map((item) => SalidaGuia.fromJson(item)).toList();
        _filteredProductos = _productos;
        print('El estado ----> ${response.statusCode}');
         print('El Cuerpo ----> ${jsonData}');
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error fetching products: $error');
    }
  }

  void searchProducto(String query) {
    if (query.isEmpty) {
      _filteredProductos = _productos;
    } else {
      _filteredProductos = _productos.where((producto) {
        return producto.cliente.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void cleanData(){
    productos.clear();
  }
}

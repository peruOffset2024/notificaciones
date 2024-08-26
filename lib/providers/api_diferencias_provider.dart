import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notificaciones/models/modelo_api_diferencias.dart';

//Provider de la pantalla principal incluye consumo de api
class ProductosProvider with ChangeNotifier {
  List<Productos> _productos = [];
  List<Productos> _filteredProductos = [];

  List<Productos> get productos => _filteredProductos;

  ProductosProvider() {
    fetchProductos();
  }

  Future<void> fetchProductos() async {
    final url = Uri.parse('http://190.107.181.163:81/amq/flutter_ajax_home.php?');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        _productos = jsonData.map((item) => Productos.fromJson(item)).toList();
        _filteredProductos = _productos;
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
      _filteredProductos = _productos;
    } else {
      _filteredProductos = _productos.where((producto) {
        return producto.descripcion.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void cleanData(){
    productos.clear();
  }
}

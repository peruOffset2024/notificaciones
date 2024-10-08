import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notificaciones/models/modelo_api_diferencias.dart';
 
//Provider de la pantalla principal incluye consumo de api
class GuiasSalidasProvider with ChangeNotifier {
  List<SalidaGuia> _productos = [];
  List<SalidaGuia> _filteredProductos = [];
  bool _isLoading = false; // Estado de carga

  // Si hay resultados filtrados, los retorna, de lo contrario devuelve una lista vacía.
  List<SalidaGuia> get productos => _filteredProductos;
  bool get isLoading => _isLoading; // Getter para el estado de carga

  Future<void> fetchProductos(String dni, String ruc) async {
    
  _isLoading = true;
  notifyListeners(); // Notificar que ha cambiado el estado de carga

  final url = Uri.parse('http://190.107.181.163:81/aqnq/ajax/lista_salidas.php?dni=$dni&ruc=$ruc');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
       // ignore: avoid_print
      print('respuestas desde la api: ---> : $jsonData'); 
      // Verificar si la respuesta contiene un mensaje de error en lugar de una lista
      if (jsonData is Map<String, dynamic> && jsonData.containsKey('error')) {
        // Manejar el caso de error
         // ignore: avoid_print
        print('Error: ${jsonData['error']}');
        _productos = [];
        _filteredProductos = [];
      } else if (jsonData is List<dynamic>) {
        // Si es una lista, procesarla normalmente
        _productos = jsonData.map((item) => SalidaGuia.fromJson(item)).toList();
        _filteredProductos = _productos; // Al principio, ambas listas son iguales
         // ignore: avoid_print
        print('Datos obtenidos desde la api: ---> : $_productos'); 
         // ignore: avoid_print
        print('Datos obtenidos desde la api: ---> : $_productos'); 
        
      } else {
        throw Exception('Unexpected response format');
      }
      
    } else {
      throw Exception('Failed to load products');
    }
  } catch (error) {
     // ignore: avoid_print
    print('Error fetching products: $error');
    
  } finally {
    _isLoading = false;
    notifyListeners(); // Notificar que ha terminado la carga
  }
}


    void eliminarGuias(String product){
      _productos.removeWhere((item) => item.nroGuia == product);
      _filteredProductos.removeWhere((item) => item.nroGuia == product);
      notifyListeners();
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/modelo_guia_x_cliente.dart';
import 'package:http/http.dart' as http;

class GuiaxClienteProvider with ChangeNotifier {
  List<GuiaxCliente> _guiaxCliente = [];

  List<GuiaxCliente> get guiaxCliente => _guiaxCliente;
 
  Future<void> obtenerGuiasDetalle(String guia) async {
    try {
      final response = await http.get(Uri.parse('http://190.107.181.163:81/aqnq/ajax/lista_guia.php?guia=$guia'));
      
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Verificar si la respuesta es un objeto que contiene un error
        if (jsonData is Map<String, dynamic> && jsonData.containsKey('error')) {
          // Manejar el caso de error
           // ignore: avoid_print
          print('Error: ${jsonData['error']}');
          _guiaxCliente = []; // Vaciar la lista si no hay datos
        } else if (jsonData is List) {
          // Procesar la lista de datos normalmente
          _guiaxCliente = jsonData.map((jsonGuia) => GuiaxCliente.fromJson(jsonGuia)).toList();
           // ignore: avoid_print
          print('Datos de guías obtenidos correctamente: $jsonData');
        } else {
          throw Exception('Unexpected response format');
        }

        notifyListeners();
      } else {
        throw Exception('Error al consumir el API');
      }
    } catch (e) {
       // ignore: avoid_print
      print('Error fetching la guia : $e');
    }
  }
}

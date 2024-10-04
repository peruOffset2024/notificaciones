import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TipoAsistenciaProvider with ChangeNotifier {
  List<Map<String, dynamic>> _tipoLista = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get tipoLista => _tipoLista;
   bool get isLoading => _isLoading;

  Future<void> fechtTipo(String dni) async {
    // ignore: avoid_print
    print('dni $dni');
    _isLoading = true;
    try {
      final url = Uri.parse('http://190.107.181.163:81/aqnq/ajax/lista_asistencia.php?usuario=$dni');
      final respuesta = await http.get(url);

      if (respuesta.statusCode == 200) {
        final jsonData = jsonDecode(respuesta.body);

        // Verificar si jsonData es una lista
        if (jsonData is List) {
          _tipoLista = List<Map<String, dynamic>>.from(jsonData);
          // ignore: avoid_print
          print('Lista obtenida: $_tipoLista');
        } else {
          throw Exception('La respuesta de la API no es una lista');
        }

        notifyListeners();
      } else {
        throw Exception('Error en la solicitud: ${respuesta.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
    _isLoading = false;
  }
}

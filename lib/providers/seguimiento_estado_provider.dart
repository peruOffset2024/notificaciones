import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SeguimientoEstadoProvider with ChangeNotifier {
  Future<void> estadoGuia(String guia, String lugarEntrega, String usuario, String latitud, String longitud) async {
    try {
      // Construir la URL con los parámetros
      final url = Uri.parse(
          'http://190.107.181.163:81/aqnq/ajax/insert_guia.php?nro_guia=$guia&otro_lugarEntrega=$lugarEntrega&usuario=$usuario&latitud=$latitud&longitud=$longitud');

      // Enviar la solicitud GET
      final response = await http.post(url);

      // Verificar la respuesta del servidor
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // ignore: avoid_print
          print('Datos insertados correctamente y estado actualizado en la base de datos.');
          
          // Aquí puedes actualizar el estado de la aplicación si es necesario
          // notifyListeners(); // Notificar a los listeners si hay cambios en el estado interno
        } else {
          throw Exception('Error del servidor: ${responseData['message']}');
        }
      } else {
        throw Exception('Error en la solicitud: Código de estado ${response.statusCode}');
      }
    } catch (e) {
       // ignore: avoid_print
      print('Error: $e');
      throw Exception('Error al intentar insertar los datos');
    }
  }
}




class SeguimientoEstadoProviders with ChangeNotifier {
  Future<void> estadoGuia(String guia, String lugarEntrega, String usuario, String latitud, String longitud) async {
    try {
      // Construir la URL con los parámetros
      final url = Uri.parse(
          'http://190.107.181.163:81/aqnq/ajax/insert_guia.php?nro_guia=$guia&otro_lugarEntrega=$lugarEntrega&usuario=$usuario&latitud=$latitud&longitud=$longitud');

      // Enviar la solicitud POST
      final response = await http.post(url);

      // Verificar la respuesta del servidor
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          // Acciones a realizar si el estado es exitoso
          // ignore: avoid_print
          print('Datos insertados correctamente y estado actualizado en la base de datos.');
          
          // Actualizar el estado de la aplicación si es necesario
          // notifyListeners(); // Notificar a los listeners si hay cambios en el estado interno
        } else {
          // Mostrar un mensaje de error si el número de guía ya existe
          _handleError(responseData['message']);
        }
      } else {
        // Mostrar un mensaje de error en caso de un código de estado HTTP inesperado
        _handleError('Error en la solicitud: Código de estado ${response.statusCode}');
      }
    } catch (e) {
      // Mostrar un mensaje de error en caso de excepción
      _handleError('Error al intentar insertar los datos: $e');
    }
  }

  void _handleError(String message) {
    // Aquí puedes mostrar un diálogo o snackbar con el mensaje de error
    // Por ejemplo:
    print('Error: $message');
    
    // Notificar a los listeners si es necesario
    notifyListeners();
  }
}

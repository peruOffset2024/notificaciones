import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MultiplesGuiasProvider with ChangeNotifier {
  Future<void> enviarMultiplesGuias(
      {required List<String> guia,
      required String lugarEntrega,
      required String usuario,
      required String latitud,
      required String longitud,
      required String distribucion,
      required String ruc,} 
      ) async {
    try {
      // Convertir la lista de guías a una cadena JSON
      String guiasFormateadas = jsonEncode(guia);
      //String guiasFormateadas2 = guia.join(',');

      final response = await http.post(
        Uri.parse(
          'http://190.107.181.163:81/aqnq/ajax/insert_guia.php?nro_guia=$guiasFormateadas&otro_lugarEntrega=$lugarEntrega&usuario=$usuario&latitud=$latitud&longitud=$longitud&distribucion=$distribucion&ruc=$ruc',
        ),
      );
      print('lugarEntrega: $lugarEntrega');
      print('usuario: $usuario');
      print('latitud: $latitud');
      print('longitud: $longitud');
      print('distribucion: $distribucion');
      print('ruc: $ruc');
       // ignore: avoid_print
      print(
          'Respuesta del servidor: ${response.body}'); // Agrega esta línea para ver la respuesta
      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response
              .body); // Intentar decodificar el JSON solo si la respuesta es válida
          if (responseData['status'] == 'success') {
             // ignore: avoid_print
            print(
                'Datos insertados correctamente y estado actualizado en la base de datos.');
          } else {
            throw Exception('Error del servidor: ${responseData['message']}');
          }
        } catch (e) {
           // ignore: avoid_print
          print('Error de formato JSON: $e');
          throw Exception('La respuesta del servidor no está en formato JSON.');
        }
      } else {
        throw Exception(
            'Error de la solicitud, estado: ${response.statusCode}');
      }
    } catch (error) {
       // ignore: avoid_print
      print('Error al enviar datos: $error');
      throw Exception('Error al intentar insertar datos');
    }
  }
}

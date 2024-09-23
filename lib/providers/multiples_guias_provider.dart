import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MultiplesGuiasProvider with ChangeNotifier{
  Future<void> EnviarMultiplesGuias(List<String> guia, String lugarEntrega, String usuario, String latitud, String longitud, String distribucion) async{
    try{
      final response = await http.post(Uri.parse('http://190.107.181.163:81/aqnq/ajax/insert_guia.php?nro_guia=$guia&otro_lugarEntrega=$lugarEntrega&usuario=$usuario&latitud=$latitud&longitud=$longitud&distribucion=$distribucion'));
      if(response.statusCode == 200){
        final responseData = jsonDecode(response.body);
        if(responseData['status'] == 'success'){
          print('Datos insertados correctamente y estado actualizado en la base de datos.');
        } else {
          throw Exception('Error del servidor: ${responseData['message']}');
        }
      } else {
        throw Exception('Error del de la solicitud estad: ${response.statusCode}');
      }
    } catch (error){
      print('Error al enviar datos: $error');
      throw Exception('Error al intentar insertar datos');
    }

  }

}
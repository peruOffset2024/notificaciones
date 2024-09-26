import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as  http;
import 'package:http_parser/http_parser.dart';

class EnvirAsistencia with ChangeNotifier{
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> envirAsistencia(
    {required String usuario,
    required String latitud,
    required String longitud,
    required String comentario,
    required String tipo,
    required List<File> imagens}
  ) async {
    final url = Uri.parse('http://190.107.181.163:81/aqnq/ajax/insert_asistencia.php');
    _setLoading(true);

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['usuario'] = usuario;
      request.fields['latitud'] = latitud;
      request.fields['longitud'] = longitud;
      request.fields['comentario'] = comentario;
      request.fields['tipo'] = tipo;
      for (var image in imagens) {
         print('Agregando imagen: ${image.path}'); // Ver la ruta de cada imagen
        request.files.add(await http.MultipartFile.fromPath(
          'img[]', // Nombre del campo en el servidor
          image.path,
          contentType: MediaType('image', 'jpeg'), // Definir tipo de archivo
        ));
    }

    final response =  await request.send();

    if(response.statusCode == 200){
      final responseBody = await response.stream.bytesToString();
      print('Respuesta del servidor: $responseBody');
      final responseData = jsonDecode(responseBody);
       print('Datos enviados correctamente: $responseData');
    }else {
         // ignore: avoid_print
        print('Error al enviar los datos: ${response.statusCode}');
      }
  } catch (e) {
       // ignore: avoid_print
      print('Error: $e');
    }
  _setLoading(false);





  
}
void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}



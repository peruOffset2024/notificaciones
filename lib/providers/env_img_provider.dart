import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class EnvioImagenesProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> enviarDatosConImagenes({
    required String nroGuia,
    required String track,
    required String latitud,
    required String longitud,
    required String usuario,
    required String comentario,
    required String? condicion,
    required String distribucion,
    required List<File> imagenes, // Agregamos las imágenes como parámetro
  }) async {
    // Validar solo si condicion es requerida (cuando se pasa '2')
  if (track == '2' && (condicion == null || condicion.isEmpty)) {
    throw ArgumentError('El campo ESTADO DE PEDIDO es requerido.');
  }

    final url = Uri.parse('http://190.107.181.163:81/aqnq/ajax/insert_track.php');

    _setLoading(true);
    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['nro_guia'] = nroGuia;
      request.fields['track'] = track;
      request.fields['latitud'] = latitud;
      request.fields['longitud'] = longitud;
      request.fields['usuario'] = usuario;
      request.fields['comentario'] = comentario;
      request.fields['condicion'] = condicion ?? '';
      request.fields['distribucion'] = distribucion;

      // Mostrar los datos que se están enviando
      print('Datos que se están enviando:');
      print('nro_guia: $nroGuia');
      print('track: $track');
      print('latitud: $latitud');
      print('longitud: $longitud');
      print('usuario: $usuario');
      print('Comentario: $comentario');
      print('Condicion: $condicion');
      print('Dsitribucion: $distribucion');

      // Agregar imágenes y mostrar sus rutas
      for (var imagen in imagenes) {
        print('Agregando imagen: ${imagen.path}'); // Ver la ruta de cada imagen
        request.files.add(await http.MultipartFile.fromPath(
          'img[]', // Nombre del campo en el servidor
          imagen.path,
          contentType: MediaType('image', 'jpeg'), // Definir tipo de archivo
        ));
      }

      // Enviar la solicitud
      final response = await request.send();

      // Verificar el estado de la respuesta
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Respuesta del servidor: $responseBody');
        final responseData = json.decode(responseBody);
        print('Datos enviados correctamente: $responseData');
      } else {
        print('Error al enviar los datos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

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
    required String viaje,
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
      request.fields['viaje'] = viaje;

      // Mostrar los datos que se están enviando
      // ignore: avoid_print
      print('Datos que se están enviando:');
       // ignore: avoid_print
      print('nro_guia: $nroGuia');
       // ignore: avoid_print
      print('track: $track');
       // ignore: avoid_print
      print('latitud: $latitud');
       // ignore: avoid_print
      print('longitud: $longitud');
       // ignore: avoid_print
      print('usuario: $usuario');
       // ignore: avoid_print
      print('Comentario: $comentario');
       // ignore: avoid_print
      print('Condicion: $condicion');
       // ignore: avoid_print
      print('Dsitribucion: $distribucion');
       // ignore: avoid_print
       print('viaje: $viaje');

      // Agregar imágenes y mostrar sus rutas
      for (var imagen in imagenes) {
         // ignore: avoid_print
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
         // ignore: avoid_print
        print('Respuesta del servidor: $responseBody');
        final responseData = json.decode(responseBody);
         // ignore: avoid_print
        print('Datos enviados correctamente: $responseData');
      } else {
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

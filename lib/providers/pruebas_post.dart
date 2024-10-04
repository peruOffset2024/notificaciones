import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class EnviarProvider with ChangeNotifier {
  bool _cargando = false;
  bool get cargando => _cargando;

  Future<void> sendData(
      {required String nroGuia,
      required String track,
      required String latitud,
      required String longitud,
      required String usuario,
      required String? condicion,
      required String distribucion,
      required String viaje,
      required List<File> imagenes}) async {
    _cargando = true;
    try {
      final request = http.MultipartRequest('POST', Uri.parse(''));
      request.fields['nro_guia'] = nroGuia;
      request.fields['track'] = track;
      request.fields['latitud'] = latitud;
      request.fields['longitud'] = longitud;
      request.fields['usuario'] = usuario;
      request.fields['condicion'] = condicion ?? '';
      request.fields['distribucion'] = distribucion;
      request.fields['viaje'] = viaje;
      for (var imagen in imagenes) {
        // ignore: avoid_print
        print('Imagenes para enviar: $imagen');
        request.files.add(await http.MultipartFile.fromPath(
            'img[]', imagen.path,
            contentType: MediaType('image', 'jpeg')));
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        // ignore: avoid_print
        print('Respuesta del servidor: $responseBody');
        final responseData = jsonDecode(responseBody);
        // ignore: avoid_print
        print('Datos enviados correctamente: $responseData');
      } else {
        // ignore: avoid_print
        print('Respuesta del servidor: ${response.statusCode}');
        throw Exception('Error al enviar datos al servidor');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
    _cargando = false;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/modelo_guia_x_cliente.dart';
import 'package:http/http.dart' as http;

class GuiaxClienteProvider with ChangeNotifier{
  List<GuiaxCliente> _guiaxCliente = [];

  List<GuiaxCliente> get guiaxCliente => _guiaxCliente;

  Future<void> obtenerGuiasDetalle(String guia) async{
    try {
      final response = await http.get(Uri.parse('http://190.107.181.163:81/aqnq/ajax/lista_guia.php?guia=$guia'));
      if(response.statusCode == 200){
        // ignore: avoid_print
        print('A quie el error de status: -----> ${response.statusCode}');
        //decodificar la respuesta JSON
        // ignore: avoid_print
        print('la guia recibida ----> $guia');
        final List<dynamic> data = jsonDecode(response.body);
        // Convertir cada elemento de la lista en un objeto ListaGuias
        _guiaxCliente = data.map((jsonGuia) => GuiaxCliente.fromJson(jsonGuia)).toList();
        // ignore: avoid_print
        print('El json -----> $data');
        notifyListeners();
      } else {
        throw Exception('Error al consumir el Api');
      }
    } catch (e){
      // ignore: avoid_print
      print('Error fetching la guia : $e');
    }
  }


}
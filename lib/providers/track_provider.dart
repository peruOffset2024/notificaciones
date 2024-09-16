import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:push_notificaciones/models/modelo_track.dart';
import 'package:http/http.dart' as http;

class TrackProviderSegui with ChangeNotifier{
  List<Track> _track = [];

  List<Track> get track => _track;

  Future<void> obtenerTrack(String guia) async {
    try{
      final response = await http.get(Uri.parse('http://190.107.181.163:81/aqnq/ajax/track.php?guia=$guia'));
      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        _track  = data.map((track) => Track.fromJson(track)).toList();
        // ignore: avoid_print
        print('Json : $data');
        notifyListeners();
      } else {
        throw Exception('Error al obtener track');
      }
    } catch(e){
      throw Exception('Error al obtener track $e');
    }
  }



}
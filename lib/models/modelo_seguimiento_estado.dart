// To parse this JSON data, do
//
//     final estadoSeguimiento = estadoSeguimientoFromJson(jsonString);

import 'dart:convert';

List<EstadoSeguimiento> estadoSeguimientoFromJson(String str) => List<EstadoSeguimiento>.from(json.decode(str).map((x) => EstadoSeguimiento.fromJson(x)));

String estadoSeguimientoToJson(List<EstadoSeguimiento> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EstadoSeguimiento {
    String nroGuia;
    String otroLugarEntrega;
    String usuario;
    String longitud;
    String latitud;

    EstadoSeguimiento({
        required this.nroGuia,
        required this.otroLugarEntrega,
        required this.usuario,
        required this.longitud,
        required this.latitud,
    });

    factory EstadoSeguimiento.fromJson(Map<String, dynamic> json) => EstadoSeguimiento(
        nroGuia: json["nro_guia"],
        otroLugarEntrega: json["otro_lugarEntrega"],
        usuario: json["usuario"],
        longitud: json["longitud"],
        latitud: json["latitud"],
    );

    Map<String, dynamic> toJson() => {
        "nro_guia": nroGuia,
        "otro_lugarEntrega": otroLugarEntrega,
        "usuario": usuario,
        "longitud": longitud,
        "latitud": latitud,
    };
}

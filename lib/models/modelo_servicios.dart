// To parse this JSON data, do
//
//     final servicios = serviciosFromJson(jsonString);

import 'dart:convert';

List<Servicios> serviciosFromJson(String str) => List<Servicios>.from(json.decode(str).map((x) => Servicios.fromJson(x)));

String serviciosToJson(List<Servicios> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Servicios {
    String item;
    DateTime fechaEmision;
    String guia;
    String cliente;
    String cant;
    String llegada;

    Servicios({
        required this.item,
        required this.fechaEmision,
        required this.guia,
        required this.cliente,
        required this.cant,
        required this.llegada,
    });

    factory Servicios.fromJson(Map<String, dynamic> json) => Servicios(
        item: json["item"] ?? '',
        fechaEmision: DateTime.parse(json["Fecha_emision"]),
        guia: json["Guia"] ?? '',
        cliente: json["Cliente"] ?? '',
        cant: json["cant"] ?? '',
        llegada: json["llegada"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "item": item,
        "Fecha_emision": fechaEmision.toIso8601String(),
        "Guia": guia,
        "Cliente": cliente,
        "cant": cant,
        "llegada": llegada,
    };
}

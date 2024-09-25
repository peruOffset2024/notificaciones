// To parse this JSON data, do
//
//     final serviciosMultiples = serviciosMultiplesFromJson(jsonString);

import 'dart:convert';

List<ServiciosMultiples> serviciosMultiplesFromJson(String str) => List<ServiciosMultiples>.from(json.decode(str).map((x) => ServiciosMultiples.fromJson(x)));

String serviciosMultiplesToJson(List<ServiciosMultiples> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiciosMultiples {
    String item;
    DateTime fechaEmision;
    String guia;
    String cliente;
    String cant;
    String llegada;

    ServiciosMultiples({
        required this.item,
        required this.fechaEmision,
        required this.guia,
        required this.cliente,
        required this.cant,
        required this.llegada,
    });

    factory ServiciosMultiples.fromJson(Map<String, dynamic> json) => ServiciosMultiples(
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

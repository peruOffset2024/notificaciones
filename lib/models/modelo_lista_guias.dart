// To parse this JSON data, do
//
//     final listaGuias = listaGuiasFromJson(jsonString);


import 'dart:convert';

List<ListaGuias> listaGuiasFromJson(String str) => List<ListaGuias>.from(json.decode(str).map((x) => ListaGuias.fromJson(x)));

String listaGuiasToJson(List<ListaGuias> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaGuias {
    String item;
    DateTime fechaEmision;
    String guia;
    String cliente;
    String cant;
    String llegada;

    ListaGuias({
        required this.item,
        required this.fechaEmision,
        required this.guia,
        required this.cliente,
        required this.cant,
        required this.llegada
    });

    factory ListaGuias.fromJson(Map<String, dynamic> json) => ListaGuias(
        item: json["item"],
        fechaEmision: DateTime.parse(json["Fecha_emision"]),
        guia: json["Guia"],
        cliente: json["Cliente"],
        cant: json["cant"], 
        llegada: json['llegada'],
    );

    Map<String, dynamic> toJson() => {
        "item": item,
        "Fecha_emision": fechaEmision.toIso8601String(),
        "Guia": guia,
        "Cliente": cliente,
        "cant": cant,
        "llegada": llegada
    };
}

// To parse this JSON data, do
//
//     final guiaxCliente = guiaxClienteFromJson(jsonString);

import 'dart:convert';

List<GuiaxCliente> guiaxClienteFromJson(String str) => List<GuiaxCliente>.from(json.decode(str).map((x) => GuiaxCliente.fromJson(x)));

String guiaxClienteToJson(List<GuiaxCliente> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GuiaxCliente {
    String op;
    String und;
    String cant;

    GuiaxCliente({
        required this.op,
        required this.und,
        required this.cant,
    });

    factory GuiaxCliente.fromJson(Map<String, dynamic> json) => GuiaxCliente(
        op: json["op"] ,
        und: json["und"],
        cant: json["cant"],
    );

    Map<String, dynamic> toJson() => {
        "op": op,
        "und": und,
        "cant": cant,
    };
}

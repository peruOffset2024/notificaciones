// To parse this JSON data, do
//
//     final productos = productosFromJson(jsonString);

import 'dart:convert';

List<Productos> productosFromJson(String str) => List<Productos>.from(json.decode(str).map((x) => Productos.fromJson(x)));

String productosToJson(List<Productos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Productos {
    String itemCode;
    String descripcion;
    String diferencia;

    Productos({
        required this.itemCode,
        required this.descripcion,
        required this.diferencia,
    });

    factory Productos.fromJson(Map<String, dynamic> json) => Productos(
        itemCode: json["ItemCode"],
        descripcion: json["Descripcion"],
        diferencia: json["diferencia"],
    );

    Map<String, dynamic> toJson() => {
        "ItemCode": itemCode,
        "Descripcion": descripcion,
        "diferencia": diferencia,
    };
}

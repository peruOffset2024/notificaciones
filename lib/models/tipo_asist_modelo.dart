// To parse this JSON data, do
//
//     final tipoAsist = tipoAsistFromJson(jsonString);

import 'dart:convert';

List<TipoAsist> tipoAsistFromJson(String str) => List<TipoAsist>.from(json.decode(str).map((x) => TipoAsist.fromJson(x)));

String tipoAsistToJson(List<TipoAsist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoAsist {
    String tipo;

    TipoAsist({
        required this.tipo,
    });

    factory TipoAsist.fromJson(Map<String, dynamic> json) => TipoAsist(
        tipo: json["tipo"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "tipo": tipo,
    };
}

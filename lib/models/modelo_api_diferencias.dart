// To parse this JSON data, do
//
//     final salidaGuia = salidaGuiaFromJson(jsonString);
import 'dart:convert';

List<SalidaGuia> salidaGuiaFromJson(String str) => List<SalidaGuia>.from(json.decode(str).map((x) => SalidaGuia.fromJson(x)));

String salidaGuiaToJson(List<SalidaGuia> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalidaGuia {
    String nroGuia;
    String cliente;
    String cant;
    String entrega;
    String? tipo;
    String ultimotrack;

    SalidaGuia({
        required this.nroGuia,
        required this.cliente,
        required this.cant,
        required this.entrega,
        required this.tipo,
        required this.ultimotrack
    });

    factory SalidaGuia.fromJson(Map<String, dynamic> json) => SalidaGuia(
        nroGuia: json["nro_guia"] ?? '',
        cliente: json["Cliente"]?? '',
        cant: json["cant"]?? '',
        entrega: json["Entrega"]?? '', 
        tipo: json["tipo"] ?? '', 
        ultimotrack: json["Ultimo_Track"]?? '',
    );

    Map<String, dynamic> toJson() => {
        "nro_guia": nroGuia,
        "Cliente": cliente,
        "cant": cant,
        "Entrega": entrega,
        "tipo": tipo,
        "ultimotrack" : ultimotrack
    };
}

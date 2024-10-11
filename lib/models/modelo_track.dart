// To parse this JSON data, do
//
//     final track = trackFromJson(jsonString);

import 'dart:convert';

List<Track> trackFromJson(String str) => List<Track>.from(json.decode(str).map((x) => Track.fromJson(x)));

String trackToJson(List<Track> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Track {
    String nroGuia;
    String paso;
    String fecha;
    String track;

    Track({
        required this.nroGuia,
        required this.paso,
        required this.fecha,
        required this.track,
    });

    factory Track.fromJson(Map<String, dynamic> json) => Track(
        nroGuia: json["nro_guia"] ?? '',
        paso: json["paso"] ?? '',
        fecha: json["fecha"] ?? '',
        track: json["track"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "nro_guia": nroGuia,
        "paso": paso,
        "fecha": fecha,
        "track": track,
    };
}

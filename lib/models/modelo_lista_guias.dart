import 'dart:convert';

List<ListaGuias> listaGuiasFromJson(String str) => List<ListaGuias>.from(
    json.decode(str).map((x) => ListaGuias.fromJson(x)));

String listaGuiasToJson(List<ListaGuias> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListaGuias {
  String item;
  FechaEmision fechaEmision;
  String guia;
  String cliente;

  ListaGuias({
    required this.item,
    required this.fechaEmision,
    required this.guia,
    required this.cliente,
  });

  factory ListaGuias.fromJson(Map<String, dynamic> json) => ListaGuias(
        item: json["item"],
        fechaEmision: fechaEmisionValues.map[json["Fecha_emision"]]!,
        guia: json["Guia"],
        cliente: json["Cliente"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "Fecha_emision": fechaEmisionValues.reverse[fechaEmision],
        "Guia": guia,
        "Cliente": cliente,
      };

  // Método para obtener el texto legible para `fechaEmision`
  String get fechaEmisionText =>
      fechaEmisionValues.reverse[fechaEmision] ?? 'Desconocido';
}

enum FechaEmision { THE_26082024, THE_27082024 }

final fechaEmisionValues = EnumValues({
  "26/08/2024": FechaEmision.THE_26082024,
  "27/08/2024": FechaEmision.THE_27082024,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

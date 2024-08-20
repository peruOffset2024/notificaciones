class Ubicacion {
  String id;
  String zona;
  String stand;
  String col;
  String fil;
  String cantidad;
  String img;

  Ubicacion({
    required this.id,
    required this.zona,
    required this.stand,
    required this.col,
    required this.fil,
    required this.cantidad,
    required this.img,
  });

  factory Ubicacion.fromJson(Map<String, dynamic> json) {
    return Ubicacion(
      id: json['id'],
      zona: json['Zona'],
      stand: json['Stand'],
      col: json['col'],
      fil: json['fil'],
      cantidad: json['Cantidad'],
      img: json['Img'] != null ? json['Img'][0] : '',
    );
  }
}

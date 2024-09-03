class PedidoEstado {
  final String estado;
  final String descripcion;
  final DateTime fecha;
  final String latitude;
  final String longitude;


  PedidoEstado( {
    required this.latitude, 
    required this.longitude,
    required this.estado,
    required this.descripcion,
    required this.fecha,
  });
}


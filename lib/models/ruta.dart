class Ruta {
  final String registro;
  final String hora;

  Ruta({
    required this.registro,
    required DateTime hora,
  }) : hora = hora.toString();
}

class Pokemon {
  final String name;
  final String imageUrl;

  Pokemon({
    required this.name,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>?; // Manejar caso null
    final imageUrl = sprites?['front_default'] ?? ''; // Usa una cadena vacía si es null

    return Pokemon(
      name: json['name'] ?? '',
      imageUrl: imageUrl,
    );
  }
}

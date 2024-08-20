import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:push_notificaciones/models/modelo_pokemon.dart';


class PokemonProvider with ChangeNotifier {
  List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  bool _isLoading = false;

  List<Pokemon> get pokemons => _filteredPokemons;
  bool get isLoading => _isLoading;

  Future<void> fetchPokemons() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100'); // Limita a 100 Pokémon para ejemplo
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      _pokemons = results.map((json) => Pokemon.fromJson(json)).toList();
      _filteredPokemons = _pokemons; // Inicialmente, muestra todos los Pokémon
    } else {
      _pokemons = [];
      _filteredPokemons = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void searchPokemon(String query) {
    _filteredPokemons = _pokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }
}



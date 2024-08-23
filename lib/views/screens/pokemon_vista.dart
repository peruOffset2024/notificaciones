import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/pokemon_provider.dart';


class SearchBarExample extends StatefulWidget {
  const SearchBarExample({super.key});

  @override
  State<SearchBarExample> createState() => _SearchBarExampleState();
}

class _SearchBarExampleState extends State<SearchBarExample> {
  @override
  void initState() {
    super.initState();
    // Fetch all Pokémon when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonProvider>(context, listen: false).fetchPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Pokémon...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onChanged: (value) {
                pokemonProvider.searchPokemon(value);
              },
            ),
          ),
          Expanded(
            child: pokemonProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: pokemonProvider.pokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = pokemonProvider.pokemons[index];
                      return ListTile(
                        title: Text(pokemon.name.toUpperCase()),
                        leading: pokemon.imageUrl.isNotEmpty
                            ? Image.network(pokemon.imageUrl, width: 50, height: 50)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

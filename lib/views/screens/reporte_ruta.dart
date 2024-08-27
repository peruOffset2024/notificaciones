import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/rutas_provider.dart';
import 'package:push_notificaciones/views/screens/registro_salida.dart';

class ReporteRutas extends StatefulWidget {
  const ReporteRutas({super.key});

  @override
  State<ReporteRutas> createState() => _ReporteRutasState();
}

class _ReporteRutasState extends State<ReporteRutas> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Guias Emitidas',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Fila de búsqueda
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          context.read<RutasProvider>().searchRuta('');
                        },
                        icon: const Icon(Icons.cancel_outlined,
                            color: Colors.black),
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      hintText: '¿Qué guía deseas buscar?',
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                             BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      context.read<RutasProvider>().searchRuta(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tabla de resultados
            Expanded(
              child: Consumer<RutasProvider>(
                builder: (context, provider, child) {
                  if (provider.rutas.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay resultados',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.rutas.length,
                    itemBuilder: (context, index) {
                      final ruta = provider.rutas[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistroSalida(
                                            isActive: true,
                                            label: ruta.registro,
                                            onChanged: (bool value) {},
                                          )));
                            },
                            child: Card(
                              color: Colors.blue[100],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      ruta.registro,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ruta.hora,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(color: Colors.white),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/rutas_provider.dart';

class RegistroRutas extends StatefulWidget {
  const RegistroRutas({super.key});

  @override
  State<RegistroRutas> createState() => _RegistroRutasState();
}

class _RegistroRutasState extends State<RegistroRutas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Fila de búsqueda
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.teal),
                      labelText: 'Buscar',
                      labelStyle: const TextStyle(color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.teal),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                      ),
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
                    return const Center(child: Text('No hay resultados'));
                  }

                  return SingleChildScrollView(
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(2),
                      },
                      border: const TableBorder(
                        horizontalInside: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 224, 224, 224),
                          style: BorderStyle.solid,
                        ),
                        bottom: BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(255, 224, 224, 224),
                          style: BorderStyle.solid,
                        ),
                      ),
                      children: provider.rutas.map((ruta) {
                        return TableRow(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                              child: Text(
                                ruta.registro,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                              child: Text(
                                ruta.hora,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
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

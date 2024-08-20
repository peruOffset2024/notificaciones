import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/rutas_provider.dart';

class CopiaRegistroRutas extends StatelessWidget {
  const CopiaRegistroRutas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Rutas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Fila de búsqueda
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                          color: Color.fromARGB(255, 35, 35, 36),
                          style: BorderStyle.solid,
                        ),
                        bottom: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 35, 35, 36),
                          style: BorderStyle.solid,
                        ),
                      ),
                      children: provider.rutas.map((ruta) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                ruta.registro,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14, color: Colors.black87),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                ruta.hora,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14, color: Colors.black87),
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

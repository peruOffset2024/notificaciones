import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/miguia_provider.dart';
import 'package:push_notificaciones/views/screens/message_screen.dart';
import 'package:push_notificaciones/views/screens/otros.dart';

class ListaGuias extends StatefulWidget {
  const ListaGuias({super.key, });

  @override
  State<ListaGuias> createState() => _ListaGuiasState();
}

class _ListaGuiasState extends State<ListaGuias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Fila de búsqueda
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        hintText: '¿Qué guía deseas buscar?',
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.white),
                    onChanged: (value) {
                      context.read<MiGuiasProvider>().buscarRuta(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
    
            // Tabla de resultados
            Expanded(
              child: Consumer<MiGuiasProvider>(
                builder: (context, provider, child) {
                  if (provider.guias.isEmpty) {
                    print(provider.guias);
                    return const Center(
                        child: Text(
                      'No hay resultados',
                      style: TextStyle(color: Colors.white),
                    ));
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
                      children: provider.guias.map((rutaso) {
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Otros(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 8.0),
                                child: Text(
                                  rutaso.registros,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MessageScreen(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 8.0),
                                child: Text(
                                  rutaso.horas,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.teal,
                                  ),
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

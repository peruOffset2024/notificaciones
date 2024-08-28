import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/lista_guias_provider.dart';
import 'package:push_notificaciones/views/screens/registro_salida.dart';

class ListaGuiasReporte extends StatefulWidget {
  const ListaGuiasReporte({super.key});

  @override
  State<ListaGuiasReporte> createState() => _ListaGuiasReporteState();
}

class _ListaGuiasReporteState extends State<ListaGuiasReporte> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch guias when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListaGuiaProvider>().fetchGuias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Guias Emitidas',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
                      contentPadding: const EdgeInsets.all(10),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          context.read<ListaGuiaProvider>().searchGuia('');
                        },
                        icon: const Icon(Icons.cancel_outlined,
                            color: Colors.black),
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      hintText: 'Filtrar por Nro. Guía',
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      context.read<ListaGuiaProvider>().searchGuia(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tabla de resultados
            Expanded(
              child: Consumer<ListaGuiaProvider>(
                builder: (context, provider, child) {
                  if (provider.guias.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay resultados',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.guias.length,
                    itemBuilder: (context, index) {
                      final guia = provider.guias[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 0.0), // Espacio mínimo entre cada Card
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistroSalida(
                                  isActive: true, // O el valor que necesites
                                  label: guia.guia,
                                  onChanged: (bool value) {},
                                  cliente: guia.cliente,
                                  guia: guia.guia,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.blue[100],
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18.0,
                                  horizontal:
                                      14.0), // Espacio general alrededor del card
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Espacio entre las dos columnas
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right:
                                              16.0), // Espacio entre la columna izquierda y la columna derecha
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Fila 1: Número de guía
                                          Text(
                                            guia.guia,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                          // Fila 2: Cliente
                                          Text(
                                            guia.cliente,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left:
                                              16.0), // Espacio entre la columna derecha y el borde del card
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          // Fila 1: Fecha de emisión
                                          Text(
                                            guia.fechaEmision
                                                .toString()
                                                .substring(0, 10),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.end,
                                          ),
                                          // Fila 2: Cantidad
                                          Text(
                                            guia.cant,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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

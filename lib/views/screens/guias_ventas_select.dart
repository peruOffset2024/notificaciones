import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/providers/env_lista_guias_provider.dart';
import 'package:push_notificaciones/providers/lista_guias_provider.dart';
import 'package:push_notificaciones/services/scroll_behavior.dart';
import 'package:push_notificaciones/views/screens/skltn_guia_emitidas.dart';
import 'package:push_notificaciones/views/screens/vista_sin_internet.dart';

class GuiasVentasSeleccionadas extends StatefulWidget {
  const GuiasVentasSeleccionadas({super.key});

  @override
  State<GuiasVentasSeleccionadas> createState() =>
      _GuiasVentasSeleccionadasState();
}

class _GuiasVentasSeleccionadasState extends State<GuiasVentasSeleccionadas> {
  
  final TextEditingController _searchController = TextEditingController();

  // Lista para almacenar las guías seleccionadas
  

  @override
  void initState() {
    super.initState();

    // Fetch guias when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ruc = context.read<Authprovider>().ruc;
      context.read<ListaGuiaProvider>().fetchGuias(ruc);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<ConnectivityProvider>().isConnected;

    return isConnected
        ? ScrollConfiguration(
            behavior:
                CustomScrollBehavior(), // Aplica el comportamiento personalizado
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  'Guias de Ventas',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              backgroundColor: Colors.white,
              body: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // Fila de búsqueda
                    TextField(
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
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        hintText: 'Filtrar por Nro. Guía',
                        hintStyle: const TextStyle(color: Colors.grey),
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
                    const SizedBox(height: 10),

                    // Tabla de resultados
                    Expanded(
                      child: Consumer<ListaGuiaProvider>(
                        builder: (context, provider, child) {
                          if (provider.isLoading) {
                            return const ShimmerLoaderWidget();
                          }
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
                              final isSelected = context.read<EnviarListaGuiasProvider>().guiasSeleccionadas.contains(guia.guia);

                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        0.0), // Espacio mínimo entre cada Card
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    color: Colors.blue[100],
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Fila 1: Número de guía
                                                  Text(
                                                    guia.guia,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  // Fila 2: Cliente
                                                  Text(
                                                    guia.cliente,
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.visible,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                  ),
                                                  // Fila 2: Cantidad
                                                  Text(
                                                    guia.cant,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Checkbox para seleccionar las guías
                                          Checkbox(
                                            value: isSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                if (value == true) {
                                                  context
                                                      .read<
                                                          EnviarListaGuiasProvider>()
                                                      .agregarGuia(guia.guia);
                                                } else {
                                                  context
                                                      .read<
                                                          EnviarListaGuiasProvider>()
                                                      .eliminarGuia(guia.guia);
                                                }
                                              });
                                                
                                              
                                            },
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

                    // Mostrar las guías seleccionadas en la parte inferior
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      final sizeb = MediaQuery.of(context).size;
                      return Container(
                        height: sizeb.height * 0.6,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: SingleChildScrollView(
                          child: Consumer<EnviarListaGuiasProvider>(
                            builder: (context, seleccionadasProvider, child) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (seleccionadasProvider.guiasSeleccionadas.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Guías seleccionadas:',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 20),
                                          Wrap(
                                            spacing: 8.0,
                                            children: seleccionadasProvider
                                                .guiasSeleccionadas
                                                .map((guia) {
                                              return Chip(
                                                label: Text(guia),
                                                backgroundColor: Colors.grey[400],
                                                onDeleted: () {
                                                  setState(() {
                                                    seleccionadasProvider
                                                      .eliminarGuia(guia);
                                                  });
                                                  
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      side: const BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                    onPressed: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.blue,
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height: 30,
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.save,
                                              size: 25, color: Colors.white),
                                          SizedBox(width: 10),
                                          Text('Guardar',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.file_open_sharp),
              ),
            ),
          )
        : const NoInternetScreen();
  }
}

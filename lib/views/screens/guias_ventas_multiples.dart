import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/providers/env_lista_guias_provider.dart';
import 'package:push_notificaciones/providers/guias_ventas_mult_provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/services/scroll_behavior.dart';
import 'package:push_notificaciones/views/screens/guia_ventas_modal_animation.dart';
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
  Location location = Location();
  bool isSwitched = false;

  //bool _isLoading = false; // Variable para controlar el estado de carga

  // Lista para almacenar las guías seleccionadas

  @override
  void initState() {
    super.initState();

    // Fetch guias when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ruc = context.read<Authprovider>().ruc;
      context.read<ListaGuiaProvider>().fetchGuias(ruc);
      context.read<EnviarListaGuiasProvider>().limpiar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<ConnectivityProvider>().isConnected;
    final listadeLasGuias = context.watch<ListaGuiaProvider>();

    return isConnected
        ? ScrollConfiguration(
            behavior:
                CustomScrollBehavior(), // Aplica el comportamiento personalizado
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  'Guias de Venta',
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
                      child: Consumer<LocationProvider>(
                        builder: (context, locprovider, child) {
                          if (locprovider.isLoading) {
                            return const ShimmerLoaderWidget();
                          }
                          if (listadeLasGuias.guias.isEmpty) {
                            return const Center(
                              child: Text(
                                'No hay resultados',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: listadeLasGuias.guias.length,
                            itemBuilder: (context, index) {
                              final guia = listadeLasGuias.guias[index];

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
                                          Checkbox(
                                            activeColor: Colors.green,
                                            checkColor: Colors.white,
                                            value: context
                                                .watch<
                                                    EnviarListaGuiasProvider>()
                                                .guiasSeleccionadas
                                                .contains(guia.guia),
                                            side: const BorderSide(
                                                color: Colors.black),
                                            onChanged: (value) {
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
                                            },
                                          ),
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
              floatingActionButton: FloatingActionButton.extended(
                elevation: 5,
                isExtended: true,
                backgroundColor: Colors.green,
                onPressed: () {
                  final guiasSeleccionadasOne = context
                      .read<EnviarListaGuiasProvider>()
                      .guiasSeleccionadas;

                  if (guiasSeleccionadasOne.isNotEmpty) {
                    // Muestra la animación de las guías seleccionadas
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ModalGuiasVentasAnimadas();
                      },
                    );
                  } else {
                    // Puedes mostrar un mensaje o un snackbar si lo deseas
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'NO TIENE SELECCIONADO NINGUNA GUIA',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }
                },
                label: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          )
        : const NoInternetScreen();
  }
}

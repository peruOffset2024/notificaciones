import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/providers/env_lista_guias_provider.dart';
import 'package:push_notificaciones/providers/guias_serv_mult_provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/providers/modal_switch_provider.dart';
import 'package:push_notificaciones/providers/multiples_guias_provider.dart';
import 'package:push_notificaciones/services/scroll_behavior.dart';
import 'package:push_notificaciones/views/screens/skltn_guia_emitidas.dart';
import 'package:push_notificaciones/views/screens/vista_sin_internet.dart';

class GuiasServiciosMultiples extends StatefulWidget {
  const GuiasServiciosMultiples({super.key});

  @override
  State<GuiasServiciosMultiples> createState() =>
      _GuiasServiciosMultiplesState();
}

class _GuiasServiciosMultiplesState extends State<GuiasServiciosMultiples> {
  final TextEditingController _searchController = TextEditingController();

  Location location = Location();

  bool isSwitched = false;

  String condicional = '';

  //bool _isLoading = false; // Variable para controlar el estado de carga
  @override
  void initState() {
    super.initState();

    // Fetch guias when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ruc = context.read<Authprovider>().ruc;
      context
          .read<GuiasServiciosMultiplesProvider>()
          .feachGuiasServicioMultiples(ruc);
      context.read<EnviarListaGuiasProvider>().limpiar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<ConnectivityProvider>().isConnected;
    final listadeLasGuias = context.watch<GuiasServiciosMultiplesProvider>();

    return isConnected
        ? ScrollConfiguration(
            behavior:
                CustomScrollBehavior(), // Aplica el comportamiento personalizado
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  'Guias de Servicio',
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
                            context
                                .read<GuiasServiciosMultiplesProvider>()
                                .feachGuiasServicioMultiples('');
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
                        context
                            .read<GuiasServiciosMultiplesProvider>()
                            .searchMultiplesGuiasServicio(value);
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
                          if (listadeLasGuias.guiasServiciosMultiples.isEmpty) {
                            return const Center(
                              child: Text(
                                'No hay Guias para Servicios',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount:
                                listadeLasGuias.guiasServiciosMultiples.length,
                            itemBuilder: (context, index) {
                              final guia = listadeLasGuias
                                  .guiasServiciosMultiples[index];
                              final isSelected = context
                                  .read<EnviarListaGuiasProvider>()
                                  .guiasSeleccionadas
                                  .contains(guia.guia);

                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        0.0), // Espacio mínimo entre cada Card
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    color: Colors.orange[100],
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
                                            value: isSelected,
                                            side: const BorderSide(
                                                color: Colors.black),
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
                isExtended: true,
                backgroundColor: Colors.green,
                onPressed: () {
                  final guiasSeleccionadasOne = context
                      .read<EnviarListaGuiasProvider>()
                      .guiasSeleccionadas;
                  // Validar si la lista tiene elementos
                  if (guiasSeleccionadasOne.isNotEmpty) {
                    _showModalBoton(context, isSwitched, condicional);
                  } else {
                    // Puedes mostrar un mensaje o un snackbar si lo deseas
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No hay guías seleccionadas'),
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

  Future<dynamic> _showModalBoton(
      BuildContext context, bool isSwitched, String condicional) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final sizeb = MediaQuery.of(context).size;

        return Stack(
          children: [
            Container(
              height: sizeb.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, -5), // sombreado superior
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'Guias Seleccionadas:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Azul oscuro estilo bancario
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿Es distribución?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: Consumer<ModalSwitchProvider>(
                            builder: (context, switchProvider, child) {
                              return Switch(
                                value: switchProvider.isSwitched,
                                onChanged: (value) {
                                  switchProvider.toggleSwitch();
                                  print('La respuesta de value: $value');
                                },
                                inactiveThumbColor: Colors.grey[200],
                                activeColor: const Color(0xFF007BFF),
                                inactiveTrackColor: Colors.grey[400],
                              );
                            },
                          ),
                        ),
                      ],
                    ),*/

                    Consumer<EnviarListaGuiasProvider>(
                      builder: (context, seleccionadasProvider, child) {
                        return seleccionadasProvider
                                .guiasSeleccionadas.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Wrap(
                                  spacing: 8.0,
                                  children: seleccionadasProvider
                                      .guiasSeleccionadas
                                      .map((guia) {
                                    return Chip(
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      label: Text(
                                        guia,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      backgroundColor: Colors.grey[300],
                                      deleteIconColor: Colors.red,
                                      onDeleted: () {
                                        setState(() {
                                          seleccionadasProvider
                                              .eliminarGuia(guia);
                                          if (seleccionadasProvider
                                              .guiasSeleccionadas.isEmpty) {
                                            Navigator.of(context).pop();
                                          }
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // Botón de registrar salida
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: sizeb.width * 0.9,
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      try {
                       /* final condicional =
                            context.read<ModalSwitchProvider>().isSwitched
                                ? '1'
                                : '0';*/
                        final guias = context
                            .read<EnviarListaGuiasProvider>()
                            .guiasSeleccionadas;
                        final usuario = context.read<Authprovider>().username;
                        final longitud = context
                            .read<LocationProvider>()
                            .currentLocation
                            ?.longitude;
                        final latitud = context
                            .read<LocationProvider>()
                            .currentLocation
                            ?.latitude;
                        await context
                            .read<MultiplesGuiasProvider>()
                            .enviarMultiplesGuias(guias, '', usuario,
                                '$latitud', '$longitud', '0');
                       
                        // ignore: use_build_context_synchronously
                        context
                            .read<GuiasServiciosMultiplesProvider>()
                            .eliminarVariasGuias(guias);

                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.blue[50],
                              title: const Text(
                                'Registro Exitoso',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: const Text(
                                'Tu registro de salida se realizó correctamente.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[350],
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                          color: Colors.black38, width: 1),
                                    ),
                                  ),
                                  child: const Text(
                                    'Aceptar',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      } catch (error) {
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.red[50],
                              content: const Text(
                                'Error: Las guías ya tienen salida.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[350],
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                          color: Colors.black38, width: 1),
                                    ),
                                  ),
                                  child: const Text(
                                    'Aceptar',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } finally {
                        // ignore: use_build_context_synchronously
                        context.read<EnviarListaGuiasProvider>().limpiar();
                        // ignore: use_build_context_synchronously
                        context.read<ModalSwitchProvider>().switchClear();
                      }
                    },
                    label: const Text('Registrar Salida'),
                    icon: const Icon(Icons.check_circle_outline),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}

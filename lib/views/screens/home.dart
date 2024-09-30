import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(child:  Text('Home')),
    );
  }

 /*Future<dynamic> _showModalBoton(
    BuildContext context, bool isSwitched, String condicional) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true, // Para que el modal ocupe más espacio si es necesario
    builder: (BuildContext context) {
      final sizeb = MediaQuery.of(context).size;
      return Stack(
        children: [
          Container(
            height: sizeb.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
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
                                // ignore: avoid_print
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
                  ),
                  Consumer<EnviarListaGuiasProvider>(
                    builder: (context, seleccionadasProvider, child) {
                      return seleccionadasProvider.guiasSeleccionadas.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Wrap(
                                spacing: 8.0,
                                children: seleccionadasProvider
                                    .guiasSeleccionadas
                                    .map((guia) {
                                  return Chip(
                                    labelPadding: const EdgeInsets.symmetric(horizontal: 2),
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
                                        seleccionadasProvider.eliminarGuia(guia);
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
                  const SizedBox(height: 50), // Espacio extra para el botón flotante
                ],
              ),
            ),
          ),
          // Botón flotante dentro del modal
          Positioned(
            bottom: 20, // Margen desde la parte inferior del modal
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: sizeb.width * 0.9, // Tamaño del botón
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    try {
                      final distribucion =
                          context.read<ModalSwitchProvider>().isSwitched ? '1' : '0';
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
                      await context.read<MultiplesGuiasProvider>().enviarMultiplesGuias(
                          guias, '', usuario, '$latitud', '$longitud', distribucion);

                      context
                          .read<GuiasServiciosMultiplesProvider>()
                          .eliminarVariasGuias(guias);

                      showDialog(
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
                      context.read<EnviarListaGuiasProvider>().limpiar();
                      context.read<ModalSwitchProvider>().switchClear();
                    }
                  },
                  label: const Text('Registrar Salida'),
                  icon: const Icon(Icons.save),
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}*/
}
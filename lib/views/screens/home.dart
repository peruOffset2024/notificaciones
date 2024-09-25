import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(child:  Text('Home')),
    );
  }

/* Future<dynamic> _showModalBoton(
      BuildContext context, bool isSwitched, String condicional) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final sizeb = MediaQuery.of(context).size;
        final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
        final containerHeight = isLandscape ? sizeb.height * 0.4 : sizeb.height * 0.6;
        return Container(
          height: containerHeight,
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
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Confirmar Registro de Salida',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366), // Azul oscuro estilo bancario
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Guías seleccionadas:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Consumer<EnviarListaGuiasProvider>(
                  builder: (context, seleccionadasProvider, child) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          if (seleccionadasProvider.guiasSeleccionadas.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 8.0,
                                    children: seleccionadasProvider
                                        .guiasSeleccionadas
                                        .map((guia) {
                                      return Chip(
                                        label: Text(
                                          guia,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        backgroundColor: Colors.grey[300],
                                        deleteIconColor: Colors.red,
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
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Distribución',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5),
              Transform.scale(
                scale: 1.2,
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
              const SizedBox(height: 10),
              // Botón de registrar salida
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor:
                        const Color(0xFF003366), // Azul oscuro bancario
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  onPressed: () async {
                    try {
                      final condicional =
                          context.read<ModalSwitchProvider>().isSwitched
                              ? '1'
                              : '0';
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
                          .enviarMultiplesGuias(guias, '', usuario, '$latitud',
                              '$longitud', condicional);
                      print('guias --> :$guias');
                      print('usuario --> :$usuario');
                      print('latitud --> :$latitud');
                      print('longitud --> :$longitud');
                      print('condicional --> :$condicional');
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.94,
                    height: 40,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, size: 24, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Registrar Salida',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }*/

  
}
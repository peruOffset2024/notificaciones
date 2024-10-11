import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/providers/guia_x_cliente_provider.dart';
import 'package:push_notificaciones/views/screens/skeleton_registro_datos.dart';
import 'package:push_notificaciones/views/screens/vista_sin_internet.dart';

class DetalleDeGuia extends StatefulWidget {
  const DetalleDeGuia({super.key, required this.cliente, required this.guia, required this.cant, required this.llegada});
final String cliente;
  final String guia;
  final String cant;
  final String llegada;

  

  @override
  State<DetalleDeGuia> createState() => _DetalleDeGuiaState();
}

class _DetalleDeGuiaState extends State<DetalleDeGuia> {
  

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GuiaxClienteProvider>().obtenerGuiasDetalle(widget.guia);
    });
  }

  @override
  Widget build(BuildContext context) {
    final obtenerGuias = context.watch<GuiaxClienteProvider>().guiaxCliente;
    final isConnected = context.watch<ConnectivityProvider>().isConnected;

    return isConnected
        ? Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                widget.guia,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Consumer<GuiaxClienteProvider>(
              builder: (context, isLoad, child) {
                if (isLoad.isLoading) {
                  return const Center(child: ShimmerRegistroSalida());
                }
                return Padding(
                  padding:const EdgeInsets.only(
                      bottom: 20,
                      right: 8,
                      left: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(widget.cliente,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'DETALLE:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(),
                              itemCount: obtenerGuias.length,
                              itemBuilder: (context, index) {
                                final jsonIndice = obtenerGuias[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(
                                              vertical: 4.0,
                                              horizontal: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(
                                                      right: 16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    jsonIndice.op,
                                                    style: TextStyle(
                                                      color: Colors
                                                          .grey[600],
                                                      fontWeight:
                                                          FontWeight
                                                              .bold,
                                                      fontSize: 10,
                                                    ),
                                                    overflow:
                                                        TextOverflow
                                                            .visible,
                                                    textAlign:
                                                        TextAlign.start,
                                                  ),
                                                  Text(
                                                    'OP',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors
                                                          .grey[600],
                                                    ),
                                                    overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                    textAlign:
                                                        TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(
                                                      left: 16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .end,
                                                children: [
                                                  Text(
                                                    jsonIndice.cant,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors
                                                          .grey[600],
                                                      fontWeight:
                                                          FontWeight
                                                              .bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                    textAlign:
                                                        TextAlign.end,
                                                  ),
                                                  Text(
                                                    jsonIndice.und,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors
                                                          .grey[600],
                                                    ),
                                                    overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                    textAlign:
                                                        TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 1.0,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'DIRECCIÓN DE ENTREGA:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          widget.llegada,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 16),
                       
                       
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : const NoInternetScreen();
  }
}

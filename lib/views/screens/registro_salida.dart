import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/models/modelo_pedido_evento.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/guia_x_cliente_provider.dart';
import 'package:push_notificaciones/providers/lista_guias_provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/providers/pedido_provider.dart';
import 'package:push_notificaciones/providers/seguimiento_estado_provider.dart';
import 'package:push_notificaciones/views/screens/skeleton_registro_datos.dart';

class RegistroSalida extends StatefulWidget {
  const RegistroSalida({
    super.key,
    required this.cliente,
    required this.guia,
    required this.cant,
    required this.llegada,
  });

  final String cliente;
  final String guia;
  final String cant;
  final String llegada;

  @override
  State<RegistroSalida> createState() => _RegistroSalidaState();
}

final TextEditingController _lugarEntrega = TextEditingController();

class _RegistroSalidaState extends State<RegistroSalida> {
  Location location = Location();
  bool _isLoading = false; // Variable para controlar el estado de carga

  @override
  void initState() { 
    super.initState();
    _lugarEntrega.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GuiaxClienteProvider>().obtenerGuiasDetalle(widget.guia);
    });
  }

  @override
  Widget build(BuildContext context) {
    final providers = context.watch<GuiaxClienteProvider>().guiaxCliente;
    final screenWidth = MediaQuery.of(context).size.width;
    final usuarioProvider = context.read<Authprovider>().username;
    //final locationProv = context.read<LocationProvider>().currentLocation;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
      body: Stack(
        children: [
          Consumer<LocationProvider>(
            builder: (context, locationProvider, child) {
              if (locationProvider.isLoading) {
                return const Center(child: ShimmerRegistroSalida());
              }
              return KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: isKeyboardVisible ? 100 : 20, right: 8, left: 8),
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                          
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'DETALLE:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Card(
                            color: Colors.white,
                            elevation: 2,
                            shape:  RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white,
                                  width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:  const EdgeInsets.symmetric(horizontal: 3.0),
                             
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: providers.length,
                                itemBuilder: (context, index) {
                                  final jsonIndice = providers[index];
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 5.0),
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
                                                    Text(
                                                      jsonIndice.op,
                                                      style:  TextStyle(
                                                        color: Colors.grey[600],
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 10,
                                                      ),
                                                      overflow:
                                                          TextOverflow.visible,
                                                      textAlign: TextAlign.start,
                                                    ),
                                                    Text(
                                                      'OP',
                                                      style:  TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey[600],
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                    Text(
                                                      jsonIndice.cant,
                                                      style:  TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey[600],
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                    ),
                                                    Text(
                                                      jsonIndice.und,
                                                      style:  TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey[600],
                                                       
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
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
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            widget.llegada, style: TextStyle(fontSize: 11,color: Colors.grey[600],),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(height: 16),
                          _buildObservationsField(),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          if (_isLoading)
            Center(
              child: Container(
                color: Colors.transparent, // Ajusta la opacidad aquí
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: screenWidth * 0.95,
        height: 45,
        child: ElevatedButton(
          onPressed: () async {
            
            setState(() {
              _isLoading = true; // Mostrar el indicador de carga
            });

            final provider = context.read<PedidoProvider>();
            final locationProv =
                context.read<LocationProvider>().currentLocation;

            // Actualizar el estado del pedido
            provider.actualizarEstado(
              PedidoEstado(
                estado: 'Salida de Perú Offset Digital',
                descripcion: widget.cliente,
                fecha: DateTime.now(),
                latitude: locationProv!.latitude.toString(),
                longitude: locationProv.longitude.toString(),
              ),
            );

            try {
              await context.read<SeguimientoEstadoProvider>().estadoGuia(
                    widget.guia,
                    _lugarEntrega.text,
                    usuarioProvider,
                    locationProv.latitude.toString(),
                    locationProv.longitude.toString(),
                  );

              // Eliminar la guía localmente en el provider
              // ignore: use_build_context_synchronously
              context.read<ListaGuiaProvider>().eliminarGuia(widget.guia);

              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color.fromRGBO(64, 64, 64, 1),
                    title: const Text(
                      'Excelente!.',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      'Tu registro de salida se realizó correctamente.',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Aceptar', style:  TextStyle(color: Colors.white),),
                      ),
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
                    backgroundColor: const Color.fromRGBO(64, 64, 64, 1),
                    
                    content: const Text(
                      'La guía ya tiene salida.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Aceptar',style:  TextStyle(color: Colors.white),),
                      ),
                    ],
                  );
                },
              );
            } finally {
              setState(() {
                _isLoading = false; // Ocultar el indicador de carga
              });
            }
            _lugarEntrega.clear();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Registrar Salida',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildObservationsField() {
    return Container(
      //padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Text(
            'OTRO LUGAR DE ENTREGA',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(' (Diferente a la guía.)',style: TextStyle(fontSize: 11),)
          ],),
          const SizedBox(height: 10),
          TextField(
            style: const TextStyle(color: Colors.black, fontSize: 13),
            controller: _lugarEntrega,
            maxLines: null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.comment, size: 25,),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.greenAccent.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding:
                  const EdgeInsets.all(10),
            ),
            
          ),
        ],
      ),
    );
  }
}
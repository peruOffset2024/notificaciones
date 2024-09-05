import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/models/modelo_pedido_evento.dart';

import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/providers/pedido_provider.dart';
import 'package:push_notificaciones/providers/track_provider.dart';
import 'package:push_notificaciones/views/screens/registro_datos.dart';

class SeguimientoPedidoScreen extends StatefulWidget {
  const SeguimientoPedidoScreen({super.key, required this.guia});
  final String guia;

  @override
  State<SeguimientoPedidoScreen> createState() =>
      _SeguimientoPedidoScreenState();
}

class _SeguimientoPedidoScreenState extends State<SeguimientoPedidoScreen> {
  final TextEditingController _observacionController = TextEditingController();
  int _estadoIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrackProviderSegui>().obtenerTrack(widget.guia);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final estados = context.watch<PedidoProvider>().estados;
    final sizeW = MediaQuery.of(context).size.height;
    final tracki = context.watch<TrackProviderSegui>().track;


    String fecha1 = '';
    String fecha2 = '';
    String fecha3 = '';
   
  
   /* for(var item in tracki){
      fecha = item.fecha;
      
    } */

    bool llegada = false;
    bool salida = false;
    bool fin = false;

    for (var item in tracki) {
      
      if (item.paso == '1') {
        fecha1 = item.fecha;
        llegada = true;
      } else if (item.paso == '2') {
        fecha2 = item.fecha;
        salida = true;
      } else if (item.paso == '3') {
        fecha3 = item.fecha;
        fin = true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Tracking: ${widget.guia}',
          style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
          color: Colors.white,
          height: sizeW,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                      child: Text(
                    '',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(llegada == true)
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistroDatos()));
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 50,
                            child: Text(
                              llegada ? 'LLEGADA' : 'LLEGADA',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ) else GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistroDatos()));
                            _showDialog(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[350],
                            radius: 50,
                            child: Text(
                              llegada ? 'LLEGADA' : 'LLEGADA',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(fecha1 == '' ? '-' : 'CLIENTE: $fecha1'),
                        Container(
                          height: 50,
                          width: 2,
                          color: Colors.grey,
                        ),
                        if(salida == true)
                        GestureDetector(
                          
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 50,
                            child: Text(
                              salida ? 'SALIDA' : 'SALIDA',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ) else GestureDetector(
                          onTap: () {
                            _showDialog(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[350],
                            radius: 50,
                            child: Text(
                              salida ? 'SALIDA' : 'SALIDA',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(fecha2 == '' ? '-' : 'CLIENTE: $fecha2'),
                        Container(
                          height: 50,
                          width: 2,
                          color: Colors.grey,
                        ),
                        
                        if(fin == true)
                        GestureDetector(
                          
                          child: const CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 50,
                            child: Text(
                              'FIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ) else GestureDetector(
                          onTap: () {
                            _showDialog(context);
                          },
                          child:  CircleAvatar(
                            backgroundColor: Colors.grey[350],
                            radius: 50,
                            child: const Text(
                              'FIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(fecha3 == '' ? '-' : 'POD: $fecha3'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text(
            'Actualizar Estado',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.greenAccent.withOpacity(0.5),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Observaciones',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _observacionController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.comment, color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Colors.greenAccent.withOpacity(0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.greenAccent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final provider = context.read<PedidoProvider>();
                    final locationProv =
                        context.read<LocationProvider>().currentLocation;
                    // final clienteProvider =context.read<ListaGuiaProvider>().guias;

                    /*final guiaprovider = context.read<ListaGuiaProvider>().guias;
                    final numGuia = widget.guia;
                    final cliente = guiaprovider.firstWhere((cliente) => cliente.cliente == numGuia,
                    orElse: () => null,
                    );*/

                    final estadosSecuenciales = [
                      PedidoEstado(
                        estado: 'Destino: ',
                        descripcion: 'yy',
                        fecha: DateTime.now(),
                        latitude: locationProv!.latitude.toString(),
                        longitude: locationProv.longitude.toString(),
                      ),
                      PedidoEstado(
                        estado: 'Salida de:  ',
                        descripcion: 'sss',
                        fecha: DateTime.now(),
                        latitude: locationProv.latitude.toString(),
                        longitude: locationProv.longitude.toString(),
                      ),
                      PedidoEstado(
                        estado: 'Llegada a PeruOfset Digital',
                        descripcion:
                            'Lurigancho-La Capitana Cal.- Archipielago Mza. C Lote. 9',
                        fecha: DateTime.now(),
                        latitude: locationProv.latitude.toString(),
                        longitude: locationProv.longitude.toString(),
                      ),
                    ];

                    if (_estadoIndex < estadosSecuenciales.length) {
                      provider
                          .actualizarEstado(estadosSecuenciales[_estadoIndex]);
                      _estadoIndex++;
                    }

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Guardar',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ignore: unused_element
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }
}

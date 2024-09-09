import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    String valor1 = '1';
    String valor2 = '2';
    String valor3 = '3';
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (llegada == true)
                          GestureDetector(
                            onTap: () {
                              // Aquí puedes agregar la acción deseada
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>  RegistroDatos(guia: widget.guia,)));
                            },
                            // Si el valor es 1 se muestra el color  verder
                            
                            child: CircleAvatar(
                              backgroundColor: Colors
                                  .green, // Cambio de color cuando se presiona
                              radius: 50,
                              child: Text(
                                'LLEGADA :$valor1',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistroDatos(
                                    guia: widget.guia,
                                    inicio: valor1,
                                    llegada: '',
                                    fin: '',
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[350],
                              radius: 50,
                              child: Text(
                                'LLEGADA: $valor1', // aqui el valor de valor
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        Text(fecha1 == '' ? '-' : 'CLIENTE: $fecha1'),
                        Container(
                          height: 50,
                          width: 2,
                          color: Colors.grey,
                        ),
                        if (salida == true)
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 50,
                              child: Text(
                                salida ? 'SALIDA' : 'SALIDA',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistroDatos(
                                    guia: widget.guia,
                                    llegada: valor2,
                                    inicio: '',
                                    fin: '',
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[350],
                              radius: 50,
                              child: Text(
                                'SALIDA: $valor2',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        Text(fecha2 == '' ? '-' : 'CLIENTE: $fecha2'),
                        Container(
                          height: 50,
                          width: 2,
                          color: Colors.grey,
                        ),
                        if (fin == true)
                          GestureDetector(
                            child: const CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 50,
                              child: Text(
                                'FIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistroDatos(
                                    guia: widget.guia,
                                    inicio: '',
                                    llegada: '',
                                    fin: valor3,
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[350],
                              radius: 50,
                              child: Text(
                                'FIN: $valor3',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
}

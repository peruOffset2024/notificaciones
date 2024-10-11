import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/providers/guias_salidar_provider.dart';
import 'package:push_notificaciones/providers/track_provider.dart';
import 'package:push_notificaciones/views/screens/detalle_guia_seguimiento.dart';
import 'package:push_notificaciones/views/screens/registro_datos.dart';
import 'package:push_notificaciones/views/screens/vista_sin_internet.dart';

class SeguimientoPedidoScreen extends StatefulWidget {
  const SeguimientoPedidoScreen({
    super.key,
    required this.guia,
    required this.viaje,
    required this.distribucion,
    required this.cliente,
    required this.cant,
    required this.llegada,
  });
  final String guia;
  final String viaje;
  final String distribucion;

  final String cliente;
  final String cant;
  final String llegada;

  @override
  State<SeguimientoPedidoScreen> createState() =>
      _SeguimientoPedidoScreenState();
}

class _SeguimientoPedidoScreenState extends State<SeguimientoPedidoScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrackProviderSegui>().track;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recargar los datos al volver a esta pantalla
    context.read<TrackProviderSegui>().obtenerTrack(widget.guia);
  }

  @override
  Widget build(BuildContext context) {
    //final estados = context.watch<PedidoProvider>().estados;
    final sizeW = MediaQuery.of(context).size.height;
    final tracki = context.watch<TrackProviderSegui>().track;
    final isConneccted = context.watch<ConnectivityProvider>().isConnected;
    final dni = context.watch<Authprovider>().username;
    final ruc = context.watch<Authprovider>().ruc;

    String fecha1 = '';
    String fecha2 = '';
    String fecha3 = '';

    String valor1 = '1';
    String valor2 = '2';
    String valor3 = '3';

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

    String invertirFecha(String fechaOriginal) {
  // Divide la fecha y la hora
  List<String> partes = fechaOriginal.split(' '); 
  String fecha = partes[0]; // Obtiene la parte de la fecha (2024-10-11)
  String hora = partes[1]; // Obtiene la parte de la hora (13:50:28)

  // Divide la fecha en año, mes y día
  List<String> fechaPartes = fecha.split('-');
  String anio = fechaPartes[0];
  String mes = fechaPartes[1];
  String dia = fechaPartes[2];

  // Reordena a formato dd-MM-yyyy
  String fechaInvertida = '$dia-$mes-$anio $hora';

  return fechaInvertida;
}


    void onReturn() {
      //Actualización de datos o refrescar la pantalla anterior
      // ignore: avoid_print
      print('Regresando a ProductosGridScreen y actualizando los datos...');
      // Puedes llamar a alguna función específica, como:
      context.read<GuiasSalidasProvider>().fetchProductos(dni, ruc);
    }

    return isConneccted
        // ignore: deprecated_member_use
        ? WillPopScope(
            onWillPop: () async {
              onReturn();
              return true;
            },
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  title: Text(
                    'TRACKING:  ${widget.guia}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
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
                                  if (llegada == true)
                                    GestureDetector(
                                      onTap: () {
                                      },
                                      // Si el valor es 1 se muestra el color  verder
                                      child: const CircleAvatar(
                                        backgroundColor: Colors
                                            .green, // Cambio de color cuando se presiona
                                        radius: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.location_pin),
                                            Text(
                                              'LLEGADA', // :$valor1
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  else
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RegistroDatos(
                                              guia: widget.guia,
                                              inicio: valor1,
                                              llegada: '',
                                              fin: '',
                                              viaje: widget.viaje,
                                              distribucion: widget.distribucion,
                                            ),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[350],
                                        radius: 50,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.location_pin),
                                            Text(
                                              'LLEGADA ', // :$valor1
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  Text(fecha1 == ''
                                      ? '-'
                                      : 'CLIENTE: ${invertirFecha(fecha1.substring(0, 19))}'),
                                  Container(
                                    height: 50,
                                    width: 5,
                                    color: Colors.grey,
                                  ),
                                  if (salida == true)
                                    GestureDetector(
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.local_shipping),
                                            Text(
                                              'SALIDA', // : $valor2
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
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
                                                viaje: widget.viaje,
                                                distribucion:
                                                    widget.distribucion),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[350],
                                        radius: 50,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.local_shipping),
                                            Text(
                                              'SALIDA', //: $valor2
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  Text(fecha2 == ''
                                      ? '-'
                                      : 'CLIENTE: ${ invertirFecha(fecha2.substring(0, 19)) }'),
                                  Container(
                                    height: 50,
                                    width: 5,
                                    color: Colors.grey,
                                  ),
                                  if (fin == true)
                                    GestureDetector(
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 50,
                                        child: Column(
                                          children: [
                                            Icon(Icons.check_circle),
                                            Text(
                                              'FIN',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
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
                                                viaje: widget.viaje,
                                                distribucion:
                                                    widget.distribucion),
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey[350],
                                        radius: 50,
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.flag_circle),
                                            Text(
                                              'FIN', //: $valor3
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  Text(fecha3 == ''
                                      ? '-'
                                      : 'POD: ${ invertirFecha( fecha3.substring(0, 19)) }'),
                                ],
                              ),
                            ),
                            // si se desea quitar------------------------------------------------------>
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'DETALLE:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            DetalleDeGuia(
                                          cliente: widget.cliente,
                                          guia: widget.guia,
                                          cant: widget.cant,
                                          llegada: widget.llegada,
                                        ),
                                        transitionDuration:
                                            const Duration(milliseconds: 350),
                                        transitionsBuilder: (context, animation,
                                            animationSecondary, child) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(
                                            color: Colors.blueGrey, width: 1)),
                                    color: Colors.amber[200],
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            height: 5,
                                            width: 60,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            height: 5,
                                            width: 40,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            height: 5,
                                            width: 60,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            height: 5,
                                            width: 40,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            height: 5,
                                            width: 60,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ))),
          )
        : const NoInternetScreen();
  }
}

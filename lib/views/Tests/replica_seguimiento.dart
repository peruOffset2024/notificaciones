import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/providers/guias_salidar_provider.dart';
import 'package:push_notificaciones/providers/track_provider.dart';
import 'package:push_notificaciones/views/Tests/efectos/shake_widget.dart';
import 'package:push_notificaciones/views/screens/registro_datos.dart';
import 'package:push_notificaciones/views/screens/vista_sin_internet.dart';

class ReplicaSeguimiento extends StatefulWidget {
  const ReplicaSeguimiento({super.key, required this.guia, required this.viaje, required this.distribucion, required this.direcEntrega, required this.cliente, required this.cantidad, required this.tipo});
  final String guia;
  final String viaje;
  final String distribucion;
  final String direcEntrega;
  final String cliente;
  final String cantidad;
  final String tipo;

  
  @override
  State<ReplicaSeguimiento> createState() => _ReplicaSeguimientoState();
}

class _ReplicaSeguimientoState extends State<ReplicaSeguimiento> with WidgetsBindingObserver {
  final ValueNotifier<bool> notifierBottonBarVisible = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrackProviderSegui>().track;
      notifierBottonBarVisible.value = true;
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
                    child: Stack(
                     fit: StackFit.expand,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Positioned.fill(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildCarrousel(context)
                                ],
                              )),
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
                                          // Aquí puedes agregar la acción deseada
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>  RegistroDatos(guia: widget.guia,)));
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
                                                fin: '', viaje: widget.viaje, distribucion: widget.distribucion,
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
                                                'LLEGADA', // :$valor1
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
                                        : 'CLIENTE: ${fecha1.substring(0, 19)}'),
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
                                                distribucion: widget.distribucion
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
                                        : 'CLIENTE: ${fecha2.substring(0, 19)}'),
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
                                                fin: valor3, viaje: widget.viaje,distribucion: widget.distribucion
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
                                        : 'POD: ${fecha3.substring(0, 19)}'),
                                  ],
                                ),
                              ),
                              
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))),
        )
        : const NoInternetScreen();
  }


  Widget _buildCarrousel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    
    return SizedBox(
      height: size.height * 0.5,
      child: Stack(
        children: [
          Positioned.fill(
              child: Hero(
            tag: 'background_${widget.tipo}', // aqui fijate
            child: Container(
              color: Color(0xFFF6F6F6),
            ),
          )),
          Positioned(
            left: 70,
            right: 70,
            top: 10,
            child: Hero(
              tag: 'number_${widget.cantidad}',
              child: ShakeWidget(
                //axis: Axi.Vertical,
                duration: Duration(milliseconds: 1400),
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      'Cliente',
                      style: TextStyle(color: Colors.black.withOpacity(0.05), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}

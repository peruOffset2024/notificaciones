import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/views/screens/guias_ventas_select.dart';
import 'package:push_notificaciones/views/screens/iniciar_sesion.dart';

import 'package:push_notificaciones/views/screens/inicio.dart';
import 'package:push_notificaciones/views/screens/asistencia.dart';
import 'package:push_notificaciones/views/screens/transporte.dart';
import 'package:push_notificaciones/views/screens/usuario_drawer.dart';
import 'package:push_notificaciones/views/screens/vista_sin_internet.dart';

class NavegadorIndex extends StatefulWidget {
  const NavegadorIndex({super.key, required this.usuario});
  final String usuario;

  @override
  State<NavegadorIndex> createState() => _NavegadorIndexState();
}

class _NavegadorIndexState extends State<NavegadorIndex> {
  int indice = 0;

  List<Widget> navegador = [
    const ProductosGridScreen(),
    const GuiasServicios(),
    const RegistroAsistencia(),
    const GuiasVentasSeleccionadas(),
    
  ];
  
  void _selectVista(int index){
    if(index == 4){
      _showExitDialog(context);
    } else {
      setState(() { 
        indice = index;
    });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<ConnectivityProvider>().isConnected;

    return  Scaffold(
            drawer: MyCustomDrawer(usuario: widget.usuario),
            body: isConnected
        ? navegador[indice] : const NoInternetScreen(),
            bottomNavigationBar: Container(
              color: Colors.black,
              child: BottomNavigationBar(
                onTap: _selectVista,
                currentIndex: indice,
                backgroundColor: Colors.blue, // Fondo negro
                selectedItemColor: Colors.white, // Ícono seleccionado blanco
                unselectedItemColor: Colors.black.withOpacity(
                    0.7), // Íconos no seleccionados blanco con opacidad
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Inicio',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_shipping,),
                    label: 'Transporte',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.timer),
                    label: 'Asistencia',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.file_copy_rounded),
                    label: 'Guias',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.exit_to_app_rounded),
                    label: 'Salir',
                  ),
                ],
              ),
            ),
          ); 
       
  }

  void _showExitDialog(BuildContext context) async {
    bool? salir = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Colors.blue[50],
          elevation: 0,
          title:
              const Text('¿Estás seguro de que deseas salir de la aplicación?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center),
          actions: <Widget>[
            const SizedBox(
              height: 100,
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[350],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.black38, width: 1)
                )
              ),
              onPressed: () {
                Navigator.of(context).pop(false); // Cierra el diálogo sin salir
              },
              child: const Text('Cancelar',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[350],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.black38, width: 1)
                )
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // Cierra la aplicación
              },
              child: const Text(
                'Sí',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
    if(salir == true){
      // ignore: use_build_context_synchronously
      context.read<Authprovider>().logout();
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const IniciarSesion()), (Route<dynamic> route) => false);
    }
  }
}

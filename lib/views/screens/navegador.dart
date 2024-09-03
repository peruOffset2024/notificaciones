import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/views/screens/index_diferencias_despacho.dart';
import 'package:push_notificaciones/views/screens/entrada_salida_registro.dart';
import 'package:push_notificaciones/views/screens/guias_servicios.dart';
import 'dart:io';
import 'package:push_notificaciones/views/screens/usuario_drawer.dart';



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
    const Center(
      child: Text(
        'Pag4',
        style: TextStyle(fontSize: 30),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final nombUsuario = context.watch<Authprovider>().conductor;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return GestureDetector(
            child:  CircleAvatar(
              backgroundColor:  Colors.blue[100],
              minRadius: 5,
              child: Text(
                nombUsuario[0],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: MyCustomDrawer(usuario: widget.usuario),
      body: navegador[indice],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: BottomNavigationBar(
          onTap: (indice) {
            if (indice == 3) {
              _showExitDialog(context); // Muestra el diálogo de confirmación
            } else {
              setState(() {
                this.indice = indice;
              });
            }
          },
          currentIndex: indice,
          backgroundColor: Colors.blue, // Fondo negro
          selectedItemColor: Colors.white, // Ícono seleccionado blanco
          unselectedItemColor: Colors.black
              .withOpacity(0.7), // Íconos no seleccionados blanco con opacidad
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fire_truck_rounded),
              label: 'Trasnporte',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Asistencia',
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

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Colors.red,
          surfaceTintColor: Colors.blue,
          iconColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Text('¿Estás seguro de que deseas salir de la aplicación?',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center),      
          actions: <Widget>[
            const SizedBox(height: 100,),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellowAccent[400],
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo sin salir
              },
              child: const Text('Cancelar',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent[400],
                elevation: 0,
              ),
              onPressed: () {
                exit(0); // Cierra la aplicación
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
  }
}

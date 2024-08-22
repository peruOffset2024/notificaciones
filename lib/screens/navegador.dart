import 'package:flutter/material.dart';
import 'package:push_notificaciones/screens/entrada_salida_registro.dart';
import 'package:push_notificaciones/screens/guias_servicios.dart';
import 'package:push_notificaciones/screens/registro_rutas.dart';
import 'dart:io';



class NavegadorIndex extends StatefulWidget {
  const NavegadorIndex({super.key, required this.usuario});
  final String usuario;

  @override
  State<NavegadorIndex> createState() => _NavegadorIndexState();
}

class _NavegadorIndexState extends State<NavegadorIndex> {
  int indice = 0;

  List<Widget> navegador = [
    const RegistroRutas(),
    const GuiasServicios(),
    const EntradaSalidaRegistro(),
    const Center(
      child: Text(
        'Pag4',
        style: TextStyle(fontSize: 30),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Bienvenido: ${widget.usuario}', style: const TextStyle(color: Colors.greenAccent),),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        
      ),
      body: navegador[indice],
      bottomNavigationBar: BottomNavigationBar(
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
        backgroundColor: const Color.fromARGB(255, 87, 86, 83),
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(color: Colors.black, Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(color: Colors.black, Icons.fire_truck_rounded),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(color: Colors.black, Icons.timer),
            label: 'Registrarse',
          ),
          BottomNavigationBarItem(
            icon: Icon(color: Colors.black, Icons.exit_to_app_rounded),
            label: 'Salir',
          ),
        ],
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación de salida'),
          content: const Text('¿Estás seguro de que deseas salir de la aplicación?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo sin salir
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                exit(0); // Cierra la aplicación
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
  }
}

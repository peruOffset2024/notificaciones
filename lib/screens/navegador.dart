import 'package:flutter/material.dart';
import 'package:push_notificaciones/screens/guias_servicios.dart';
import 'package:push_notificaciones/screens/marcador.dart';
import 'package:push_notificaciones/screens/registro_rutas.dart';

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
    const RegistroMarcador(),
    const Center(child: Text('Pag4', style: TextStyle(fontSize: 30),))
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Bienvenido: ${widget.usuario}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF004D40),
      ),
      body: navegador[indice],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              indice = index;
            });
          },
          currentIndex: indice,
          backgroundColor: const Color.fromARGB(255, 87, 86, 83),
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(
              color: Colors.black,
              Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  color: Colors.black,
                  Icons.fire_truck_rounded), label: 'Buscar'),
            BottomNavigationBarItem(icon: Icon(
              color: Colors.black,
              Icons.timer), label: 'Buscar'),
            BottomNavigationBarItem(
                icon: Icon(
                  color: Colors.black,
                  Icons.exit_to_app_rounded), label: 'Buscar'),
          ]),
    );
  }
}

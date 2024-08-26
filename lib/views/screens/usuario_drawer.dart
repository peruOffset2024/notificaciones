import 'package:flutter/material.dart';
import 'package:push_notificaciones/views/screens/configuraciones_privacidad.dart';
import 'package:push_notificaciones/views/screens/drawer_control_asistencia.dart';
import 'package:push_notificaciones/views/screens/drawer_guias.dart';
import 'package:push_notificaciones/views/screens/seguimiento_pedido.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key, required this.usuario});
  final String usuario;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[850],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(31, 202, 183, 183) // Fondo negro
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 30,
                  child: Text(
                    'R',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      'Bienvenido',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                     Text(
                      usuario,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.white),
            title: const Text('Seguimiento', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al hacer clic en "Agregar cuenta"
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  SeguimientoPedidoScreen()));
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.flash_on, color: Colors.white),
            title: const Text('Guias', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al hacer clic en "Novedades"
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const GuiasScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.white),
            title: const Text('Historial de Asistencias', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al hacer clic en "Historial de Asistencias"
               Navigator.push(context, MaterialPageRoute(builder: (context)=> const DrawerHistorialAsistencia() ));
                
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Configuración y privacidad', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al hacer clic en "Configuración y privacidad"
               Navigator.push(context, MaterialPageRoute(builder: (context)=> const ConfiguracionesPrivacidadScreen() ));
              
            },
          ),
        ],
      ), // Fondo del Drawer
    );
  }
}

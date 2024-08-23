import 'package:flutter/material.dart';
import 'package:push_notificaciones/views/screens/drawer_control_asistencia.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key, required this.usuario});
  final String usuario;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black87, // Fondo negro
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
                      usuario,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ver perfil',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add, color: Colors.white),
            title: const Text('Rutas', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al hacer clic en "Agregar cuenta"
            },
          ),
          ListTile(
            leading: const Icon(Icons.flash_on, color: Colors.white),
            title: const Text('Guias', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Acción al hacer clic en "Novedades"
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
            },
          ),
        ],
      ), // Fondo del Drawer
    );
  }
}

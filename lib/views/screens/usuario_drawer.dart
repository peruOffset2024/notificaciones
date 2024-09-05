import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/views/screens/configuraciones_privacidad.dart';
import 'package:push_notificaciones/views/screens/drawer_control_asistencia.dart';
import 'package:push_notificaciones/views/screens/drawer_guias.dart';
import 'package:push_notificaciones/views/screens/seguimiento_pedido.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key, required this.usuario});
  final String usuario;

  @override
  Widget build(BuildContext context) {
    final nombUsuario = context.watch<Authprovider>().conductor;
    final ruc = context.watch<Authprovider>().ruc;
    
    List<String> nombCompleto = nombUsuario.split(' ');
    String nombUserComplete = nombCompleto.sublist(0, nombCompleto.length >= 2 ? 2 : nombCompleto.length).join(' ');
    

    return Drawer(
      backgroundColor: Colors.blue,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue, // Fondo negro
            ),
            child: Row(
              children: [
                 CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 30,
                  child:  Text(
                      nombUsuario[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                     const Text(
                      'Bienvenido',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                     Text(
                      nombUserComplete,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(ruc, style: TextStyle(fontSize: 10, color: Colors.grey[400]),)
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  const SeguimientoPedidoScreen(guia: '',)));
              
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

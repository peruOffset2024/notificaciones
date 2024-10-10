import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/views/screens/iniciar_sesion.dart';



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
      backgroundColor: const Color.fromARGB(255, 248, 144, 144),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
             
              color:  Color.fromARGB(255, 248, 144, 144), // Fondo rojo
            ),
            child: Row(
              children: [
                 CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child:  Text(
                      nombUsuario[0],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.visible,
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
                        color: Colors.blue,
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
                    Text(ruc, style: TextStyle(fontSize: 10, color: Colors.black54),),
                  ],
                ),
              ],
            ),
          ),
          
          
          
          /*ListTile(
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
          ),*/
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
            onTap: () {
              // Acción al hacer clic en "Salir de la aplicacion"
              _salirDeLaAplicacion(context);
            },
          ),
        ],
      ), // Fondo del Drawer
    );
  }


  void _salirDeLaAplicacion(BuildContext context) async {
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/ingreso_salida_provider.dart';
import 'package:push_notificaciones/views/screens/foto_registro.dart';
import 'package:push_notificaciones/views/screens/usuario_drawer.dart';

class RegistroAsistencia extends StatelessWidget {
  const RegistroAsistencia({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    final user = context.watch<Authprovider>().conductor;
    final asistenciaProvider = context.watch<IngresoSalidaAsistencia>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Builder(builder: (context) {
            return GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.red[100],
                minRadius: 25,
                child: Text(
                  user[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          const SizedBox(width: 10),
        ],
      ),
      drawer: MyCustomDrawer(usuario: user),
      body: Container(
        width: sizeW,
        height: sizeH,
        decoration: const BoxDecoration(
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // Botón de Ingreso
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FotoRegistro()));
                          asistenciaProvider.ingresoHabilitado ? asistenciaProvider.registrarIngreso : null;
                          
                        },
                        child: ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: asistenciaProvider.ingresoHabilitado ? Colors.green : Colors.green.withOpacity(0.5),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'INGRESO',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                
                      // Botón de Salida
                      GestureDetector(
                        onTap: asistenciaProvider.salidaHabilitada ? asistenciaProvider.registrarSalida : null,
                        child: ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: asistenciaProvider.salidaHabilitada ? Colors.red : Colors.red.withOpacity(0.5),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'SALIDA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Es importante registrar Tu ingreso y salida',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

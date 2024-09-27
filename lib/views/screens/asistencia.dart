import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/foto_asistencia_provider.dart';
import 'package:push_notificaciones/providers/tipo_asistencia_provider.dart';
import 'package:push_notificaciones/views/screens/confirmacion_asistencia.dart';
import 'package:push_notificaciones/views/screens/usuario_drawer.dart';

class RegistroAsistencia extends StatefulWidget {
  const RegistroAsistencia({super.key});

  @override
  State<RegistroAsistencia> createState() => _RegistroAsistenciaState();
}

class _RegistroAsistenciaState extends State<RegistroAsistencia> with WidgetsBindingObserver {
  String tipo1 = '';

  @override
  void initState() {
    super.initState();
    // Limpiar las imágenes cuando se inicializa la vista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FotoAsistenciaProvider>().clearImages();
      final dni = context.read<Authprovider>().username;
      context.read<TipoAsistenciaProvider>().fechtTipo(dni);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    final user = context.watch<Authprovider>().conductor;
    final tipoAsistenciaProvider = Provider.of<TipoAsistenciaProvider>(context);

    // Verifica que la lista tenga al menos dos elementos
    if (tipoAsistenciaProvider.tipoLista.length < 2) {
      return const Center(
          child: Text('No hay suficientes datos para mostrar.'));
    }
    // Obtén los valores de "tipo" del primer y segundo elemento de la lista
    final variable1 = tipoAsistenciaProvider.tipoLista[0]['tipo'];
    final variable2 = tipoAsistenciaProvider.tipoLista[1]['tipo'];

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
        decoration: const BoxDecoration(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              
              children: [
                // const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text('$variable1'),
                      Text('$variable2'),
                      

                      // Botón de Ingreso
                      variable1 < 1 ?
                      GestureDetector(
                        onTap: () {
                          /* asistenciaProvider.ingresoHabilitado
                            ? asistenciaProvider.registrarIngreso
                            : '';*/
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ConfirmacionAsistencia(
                                        tipo1: '1',
                                      )));
                        },
                        child: ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.green,
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
                      ) :  ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey,
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
                      const SizedBox(height: 50),

                      // Botón de Salida
                      variable2 < 2  ? 
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ConfirmacionAsistencia(
                                        tipo1: '2',
                                      )));
                        },
                        child: ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.red,
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
                      ) : ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey,
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Es importante registrar tu ingreso y salida',
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

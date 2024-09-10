import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/views/screens/usuario_drawer.dart';

class RegistroAsistencia extends StatefulWidget {
  const RegistroAsistencia({super.key});

  @override
  State<RegistroAsistencia> createState() => _RegistroAsistenciaState();
}

class _RegistroAsistenciaState extends State<RegistroAsistencia> {
  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    final user = context.watch<Authprovider>().conductor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Tus guías',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Builder(builder: (context) {
            return GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.red[100],
                minRadius: 20,
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF36D1DC),
              Color(0xFF5B86E5),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY6pBebZ9bw6O9gLnittGG3K2pnA7O76DgPQ&s', 
                  ),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 30),
                Card(
                  color: Colors.white.withOpacity(0.9),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bienvenido',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Acción para registrar inicio
                          },
                          icon: const Icon(Icons.login, color: Colors.white),
                          label: const Text(
                            'Registrar Ingreso',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            elevation: 5,
                            shadowColor: Colors.greenAccent,
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Acción para registrar salida
                          },
                          icon: const Icon(Icons.logout, color: Colors.white),
                          label: const Text(
                            'Registrar Salida',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            elevation: 5,
                            shadowColor: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tus guías estarán aquí',
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

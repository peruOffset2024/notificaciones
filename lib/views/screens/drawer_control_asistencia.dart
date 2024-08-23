import 'package:flutter/material.dart';

class DrawerHistorialAsistencia extends StatelessWidget {
  const DrawerHistorialAsistencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Text(
              'Historial Reciente',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _buildHistorialReciente(),
            ),
        ],),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          _mostrarAyuda(context);
        },
        child: const Icon(Icons.live_help_outlined),
        ),
    );
  }
  Widget _buildHistorialReciente() {
    return ListView(
      children: List.generate(5, (index) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: const Icon(Icons.person, color: Colors.blueGrey),
            title: Text('Empleado ${index + 1}'),
            subtitle: const Text('Inicio: 09:00 AM - Fin: 05:00 PM'),
            trailing: const Text('8h'),
          ),
        );
      }),
    );
  }

  void _mostrarAyuda(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ayuda'),
          content: const Text(
              'Aquí puedes registrar la hora de inicio y salida de tu jornada laboral. '
              'Para registrar tu entrada, ingresa tu ID de empleado y presiona "Registrar Inicio". '
              'Para registrar la salida, haz lo mismo pero presiona "Registrar Salida".'),
          actions: [
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

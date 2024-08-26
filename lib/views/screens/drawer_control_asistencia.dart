import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/asistencia_provider.dart';


class DrawerHistorialAsistencia extends StatelessWidget {
  const DrawerHistorialAsistencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'Historial de Asistencia',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mes: Agosto',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildHistorialReciente(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarAyuda(context);
        },
        backgroundColor: Colors.greenAccent[400],
        child: const Icon(Icons.live_help_outlined, color: Colors.black),
      ),
    );
  }

  Widget _buildHistorialReciente(BuildContext context) {
    final asistencias = Provider.of<AsistenciaProvider>(context).asistencias;

    return ListView.builder(
      itemCount: asistencias.length,
      itemBuilder: (context, index) {
        final asistencia = asistencias[index];
        return Card(
          color: Colors.grey[900],
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.greenAccent[400],
              child: const Icon(Icons.person, color: Colors.black),
            ),
            title: Text(
              asistencia['nombre']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Inicio: ${asistencia['inicio']} - Fin: ${asistencia['fin']}',
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: Text(
              asistencia['horas']!,
              style: const TextStyle(color: Colors.greenAccent),
            ),
          ),
        );
      },
    );
  }

  void _mostrarAyuda(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Ayuda',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Aquí puedes ver el historial reciente de asistencia de los empleados. '
            'Para registrar la asistencia, dirígete a la pantalla principal.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              child: const Text('Cerrar', style: TextStyle(color: Colors.greenAccent)),
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

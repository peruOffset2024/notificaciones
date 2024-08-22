import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/tracking_provider.dart';

class ControlView extends StatelessWidget {
  const ControlView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Ubicación'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Obtener el TrackingProvider y avanzar al siguiente punto
            context.read<TrackingProvider>().moveToNextLocation();
          },
          child: const Text('Avanzar al Siguiente Punto'),
        ),
      ),
    );
  }
}

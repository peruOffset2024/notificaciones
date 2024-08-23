import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/tracking_provider.dart';
import 'package:push_notificaciones/views/screens/registro_salida.dart';

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
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Obtener el TrackingProvider y avanzar al siguiente punto
                context.read<TrackingProvider>().moveToNextLocation();
              },
              child: const Text('Avanzar al Siguiente Punto'),
            ),
            SizedBox(height: 100,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistroSalida(isActive: true, label: '159144', onChanged: (bool value) {  },)));
            }, child: Text('search'))
          ],
        ),
      ),
    );
  }
}

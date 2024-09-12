import 'package:flutter/material.dart';

class VistaSinUbicacion extends StatefulWidget {
  const VistaSinUbicacion({super.key});


  @override
  State<VistaSinUbicacion> createState() => _VistaSinUbicacionState();
}

class _VistaSinUbicacionState extends State<VistaSinUbicacion> {
  bool isLocationEnabled = false;

  // Simulación de la activación de la ubicación (reemplazar con lógica real)
  Future<void> _enableLocation() async {
    // Lógica para solicitar al usuario activar la ubicación
    // ...
    setState(() {
      isLocationEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... resto de tu Scaffold
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... tus widgets existentes
            ElevatedButton(
              onPressed: () {
                if (isLocationEnabled) {
                  // Navegar a la pantalla principal
                  Navigator.pushNamed(context, '/home');
                } else {
                  _enableLocation();
                }
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
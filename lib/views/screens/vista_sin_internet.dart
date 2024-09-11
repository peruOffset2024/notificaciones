import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícono de advertencia
            Icon(
              Icons.wifi_off_rounded,
              size: 100,
              color: Colors.redAccent,
            ),
            SizedBox(height: 30),

            // Mensaje de "No Conexión"
            Text(
              "Oops, no hay conexión a internet",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),

            // Subtítulo explicativo
            Text(
              "Por favor verifica tu conexión e intenta nuevamente.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 40),

            // Botón de reintentar
            
          ],
        ),
      ),
    );
  }
}

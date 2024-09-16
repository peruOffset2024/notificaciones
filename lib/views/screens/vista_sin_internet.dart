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
        decoration: const BoxDecoration(),
        child: const SingleChildScrollView(
          child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage(
                  'assets/movil.jfif',
                )),
                // Ícono de advertencia
            
                // Mensaje de "No Conexión"
                Text(
                  "Sin conexión a internet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

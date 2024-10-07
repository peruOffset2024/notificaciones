import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  

  const NoInternetScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sin conexión a internet",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
           
              /*Image(
                height: size.height * 0.4,
                  image: const AssetImage(
                'assets/movil.jfif',
              )),*/
              // Ícono de advertencia
          
              // Mensaje de "No Conexión"
              
            ],
          ),
        ),
      ),
    );
  }
}

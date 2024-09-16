import 'package:flutter/material.dart';

class FotoRegistro extends StatefulWidget {
  const FotoRegistro({super.key});

  @override
  State<FotoRegistro> createState() => _FotoRegistroState();
}

class _FotoRegistroState extends State<FotoRegistro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Foto'),
              SizedBox(height: 20,),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey,
              )
            ],
          ),
        ),
      ),
    );
  }
}

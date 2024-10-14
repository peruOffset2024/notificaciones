import 'package:flutter/material.dart';

class IndicadorDeCarga extends StatelessWidget {
  const IndicadorDeCarga({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CircularProgressIndicator( color: Colors.white,),
               SizedBox(height: 5,),
              Text('Cargando...', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.normal),)
            ],
          ),
        ),
      ),
    );
  }
}
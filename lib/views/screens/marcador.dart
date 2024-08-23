import 'package:flutter/material.dart';
import 'package:push_notificaciones/views/screens/entrada_salida_registro.dart';

class RegistroMarcador extends StatelessWidget {
  const RegistroMarcador({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledColor: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  RegistroAsistencia()),
                      );
                    },
                    color: const Color.fromARGB(255, 43, 43, 44),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.2,
                        vertical: size.height * 0.02,
                      ),
                      child: const Text(
                        'MARCAR ENTRADA',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 200,
              ),
              Container(
                  padding: const EdgeInsets.all(5),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledColor: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  RegistroAsistencia()),
                      );
                    },
                    color: const Color.fromARGB(255, 43, 43, 44),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.2,
                        vertical: size.height * 0.02,
                      ),
                      child: const Text(
                        'MARCAR SALIDA',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

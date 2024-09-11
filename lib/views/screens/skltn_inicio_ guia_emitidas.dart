import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderWidget extends StatelessWidget {
  const ShimmerLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6, // Número de placeholders que quieres mostrar
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              //color: Colors.blue[100],
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Row(
                  children: [
                    // Placeholder para el lado izquierdo (nroGuia, cliente, entrega)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Simulación del número de guía (nroGuia)
                        Container(
                          width: 100,
                          height: 20,
                          color: Colors.green, // Placeholder para nroGuia
                        ),
                        const SizedBox(height: 8),
                        // Simulación del cliente
                        Container(
                          width: 150,
                          height: 12,
                          color: Colors.red, // Placeholder para cliente
                        ),
                        const SizedBox(height: 8),
                        // Simulación del lugar de entrega
                        Container(
                          width: 120,
                          height: 10,
                          color: Colors.blue, // Placeholder para entrega
                        ),
                      ],
                    ),
                    Spacer(),
                    // Placeholder para el lado derecho (cantidad)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Simulación de la cantidad
                        Container(
                          width: 50,
                          height: 12,
                          color: Colors.white, // Placeholder para cantidad
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    // Placeholder para el icono de flecha
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromARGB(255, 161, 188, 211),
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

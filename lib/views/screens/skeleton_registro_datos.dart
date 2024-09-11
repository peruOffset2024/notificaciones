import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRegistroSalida extends StatelessWidget {
  const ShimmerRegistroSalida({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          shimmerContainer(height: 20, width: 200), // Título del cliente
          const SizedBox(height: 30),
          shimmerContainer(height: 15, width: 100), // Texto 'DETALLE:'
          const SizedBox(height: 10),
          // Tarjeta de detalles
          shimmerContainer(height: 100, width: double.infinity),
          const SizedBox(height: 20),
          shimmerContainer(height: 15, width: 150), // Texto 'DIRECCIÓN DE ENTREGA:'
          const SizedBox(height: 10),
          shimmerContainer(height: 20, width: double.infinity), // Dirección de entrega
          const SizedBox(height: 20),
          shimmerContainer(height: 15, width: 180), // Texto 'OTRO LUGAR DE ENTREGA'
          const SizedBox(height: 10),
          shimmerContainer(height: 40, width: double.infinity), // Campo de texto del lugar de entrega
        ],
      ),
    );
  }

  Widget shimmerContainer({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

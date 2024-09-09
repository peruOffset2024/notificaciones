import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderWidget extends StatelessWidget {
  const ShimmerLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Número de ítems que quieres mostrar en el skeleton
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Simulando el contenido del primer Container
                            Container(
                              color: Colors.grey[200],
                              height: 20,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 8),
                            // Simulando el contenido del segundo Container
                            Container(
                              color: Colors.grey[200],
                              height: 16,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 8),
                            // Simulando el contenido del tercer Container
                            Container(
                              color: Colors.grey[200],
                              height: 14,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Simulando el contenido del cuarto Container
                            Container(
                              color: Colors.grey[200],
                              height: 20,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
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

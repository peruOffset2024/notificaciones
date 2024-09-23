import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCargaImages extends StatefulWidget {
  const ShimmerCargaImages({super.key});

  @override
  State<ShimmerCargaImages> createState() => _ShimmerCargaImagesState();
}

class _ShimmerCargaImagesState extends State<ShimmerCargaImages> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

  }
}
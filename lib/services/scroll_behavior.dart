import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return GlowingOverscrollIndicator(
      axisDirection: axisDirection,
      color: Colors.black, // Cambia el color del overscroll
      child: child,
      showLeading: true,  // Mostrar el overscroll en la parte superior/izquierda
      showTrailing: true, // Mostrar el overscroll en la parte inferior/derecha
    );
  }
}

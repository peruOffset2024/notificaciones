import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return GlowingOverscrollIndicator(
      axisDirection: axisDirection,
      color: Colors.blue, // Cambia el color del overscroll
      child: child,
    );
  }
}

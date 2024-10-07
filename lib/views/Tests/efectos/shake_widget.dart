import 'package:flutter/material.dart';

class ShakeWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double deltaX;
  final Curve curve;

  const ShakeWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.deltaX = 20,
    this.curve = Curves.bounceOut,
  }) : super(key: key);

  double shake(double animation) =>
      2 * (0.5 - (0.5 - curve.transform(animation)).abs());

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>( 

      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, animation, child) => Transform.translate(
        offset: Offset(deltaX * shake(animation), 0),
        child: child,
      ),
      child: child, 

    );
  }
}
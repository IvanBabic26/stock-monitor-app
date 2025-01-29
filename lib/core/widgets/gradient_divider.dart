import 'package:flutter/material.dart';

class GradientDivider extends StatelessWidget {
  final double height;
  final List<Color> colors;

  const GradientDivider({
    super.key,
    this.height = 4.0,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
    );
  }
}

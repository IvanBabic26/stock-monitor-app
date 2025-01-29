import 'package:flutter/material.dart';

class SkeletonItem extends StatelessWidget {
  const SkeletonItem({super.key, this.height = 12, this.width = 56});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        gradient: LinearGradient(
          colors: [Colors.grey, Colors.grey.shade300],
        ),
      ),
    );
  }
}

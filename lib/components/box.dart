import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? width;
  final double? height;

  const MyBox(
      {super.key,
      required this.child,
      required this.color,
      this.margin,
      this.padding,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

class BlurContainer extends StatelessWidget {

  final BorderRadiusGeometry borderRadius;
  final double height;
  final double? width;
  final Color color;
  final double opacity;
  final Widget? child;

  const BlurContainer({ 
    Key? key, 
    this.height = 50,
    this.width,
    this.borderRadius = BorderRadius.zero, 
    this.color = Colors.white, 
    this.opacity = 0.11, 
    this.child 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10, sigmaY: 10
        ),
        child: Container(
          height: height,
          width: width,
          color: color.withOpacity(opacity),
          child: child,
        ),
      ),
    );
  }
}
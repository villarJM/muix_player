import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class CirclePainter extends CustomPainter {
  final double radius;

  CirclePainter(this.radius);

  void paint(Canvas canvas, Size size) {
    double radius = min(size.width / 2, size.height / 2);
    Paint paint = Paint()..color = Colors.white.withOpacity(0.5);

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);

    // Dibujar el disco interno
    double innerRadius = radius * 0.3; // Define el tamaño del disco interno
    Paint innerPaint = Paint()..color = AppMuixTheme.background;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), innerRadius, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
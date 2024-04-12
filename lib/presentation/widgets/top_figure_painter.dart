import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TopFigurePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final A = Offset(size.width, size.height);
    const B = Offset(0, 150);
    
    final xC = (A.dx + B.dx) / 2;
    final yC = (A.dy + B.dy) / 2;

    final paint = Paint()
    // ..color = Colors.white
    ..shader = ui.Gradient.linear(
      Offset(xC, yC),
      Offset(size.width, 0), 
      [
        Colors.black,
        const Color.fromARGB(255, 34, 33, 30)
      ]
    )
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

    final path = Path();

    
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.width);

    path.lineTo(size.width, size.height);
    path.lineTo(0, 150);

    path.lineTo(0, 0);

    canvas.drawPath(path, paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  
}
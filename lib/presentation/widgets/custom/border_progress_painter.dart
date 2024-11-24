import 'package:flutter/material.dart';

class BorderProgressPainter extends CustomPainter {
  final double progress; // Progreso relativo (0.0 a 1.0)
  final double buffered; // Progreso del búfer relativo (0.0 a 1.0)
  final double borderRadius;
  final Color progressColor;
  final Color bufferedColor;

  const BorderProgressPainter({
    required this.progress,
    required this.buffered,
    required this.borderRadius,
    required this.progressColor,
    required this.bufferedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintBackground = Paint()
      //..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final bufferedPaint = Paint()
      ..color = bufferedColor.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    // Fondo gris del borde
    canvas.drawRRect(rrect, paintBackground);

    // Progreso del búfer
    final bufferedPath = Path()..addRRect(rrect);
    final totalLength = bufferedPath.computeMetrics().first.length;
    final bufferedLength = totalLength * buffered;

    final bufferedMetric = bufferedPath.computeMetrics().first;
    final bufferedExtractPath = bufferedMetric.extractPath(0, bufferedLength);
    canvas.drawPath(bufferedExtractPath, bufferedPaint);

    // Progreso actual
    final progressPath = Path()..addRRect(rrect);
    final progressLength = totalLength * progress;

    final progressMetric = progressPath.computeMetrics().first;
    final progressExtractPath = progressMetric.extractPath(0, progressLength);
    canvas.drawPath(progressExtractPath, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
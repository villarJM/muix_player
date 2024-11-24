import 'package:flutter/material.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';

class ProgressBorder extends StatelessWidget {
  final Duration progress; // Progreso actual
  final Duration duration; // Duración total
  final Duration buffered; // Progreso del búfer
  final double borderRadius;
  final Color progressColor;
  final Color bufferedColor;
  final ValueChanged<Duration>? onSeek; // Callback para notificar el tiempo buscado

  const ProgressBorder({
    super.key,
    required this.progress,
    required this.duration,
    required this.buffered,
    required this.borderRadius,
    this.progressColor = Colors.blue,
    this.bufferedColor = Colors.grey,
    this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanUpdate: (details) {
            _handleSeek(details.localPosition, constraints.biggest);
          },
          onTapDown: (details) {
            _handleSeek(details.localPosition, constraints.biggest);
          },
          child: CustomPaint(
            size: constraints.biggest,
            painter: BorderProgressPainter(
              progress: progress.inMilliseconds.toDouble() / 
                        duration.inMilliseconds.toDouble(),
              buffered: buffered.inMilliseconds.toDouble() / 
                        duration.inMilliseconds.toDouble(),
              borderRadius: borderRadius,
              progressColor: progressColor,
              bufferedColor: bufferedColor,
            ),
            child: const Center(child: PlayerControl()),
          ),
        );
      },
    );
  }

  void _handleSeek(Offset localPosition, Size size) {
    // Calcula el porcentaje de progreso basado en la posición táctil
    final dx = localPosition.dx.clamp(0.0, size.width);
    final newProgressFraction = dx / size.width;

    // Convierte el porcentaje a un tiempo en duración
    final newProgress = Duration(
      milliseconds: (newProgressFraction * duration.inMilliseconds).toInt(),
    );

    // Llama al callback para notificar el tiempo actualizado
    if (onSeek != null) {
      onSeek!(newProgress);
    }
  }
}
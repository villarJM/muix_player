import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/notifiers/progress_notifier.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/util/util.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingScreen extends StatefulWidget {


  const PlayingScreen({
    Key? key, 
  }) : super(key: key);

  @override
  PlayingScreenState createState() => PlayingScreenState();
}

class PlayingScreenState extends State<PlayingScreen> {

  final audioManager = getIt<AudioManager>();
  int age = 0;

  double getNormalizedValue(Duration duration, Duration maxDuration) {
    // Asegúrate de que maxDuration no sea cero para evitar una división por cero
    if (maxDuration.inMilliseconds <= 0) {
      throw ArgumentError("maxDuration debe ser mayor que cero.");
    }

    // Normaliza la duración para que esté entre 0.0 y 1.0
    double normalizedValue = duration.inMilliseconds / maxDuration.inMilliseconds;

    // Asegúrate de que el valor esté limitado entre 0.0 y 1.0
    return normalizedValue.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MediaItem>(
      valueListenable: audioManager.currentSongTitleNotifier,
      builder: (_,value, __) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: LoadArtwork(
                  id: int.parse(value.id), 
                  artworkType: ArtworkType.AUDIO,
                  size: 1600,
                  quality: FilterQuality.high,
                  height: 360,
                  width: MediaQuery.of(context).size.width * 0.9,
                  radius: 20,
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(), 
                        icon: const Iconify(Ic.round_chevron_left, 
                           
                          size: 35,
                        )
                      ),
                      const Text('Playing Now'),
                      IconButton(
                        onPressed: (){}, 
                        icon: const Iconify(Jam.menu, 
                           
                          size: 35,
                        )
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 70.h,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     child: GlassContainer(
              //       height: 130,
              //       width: MediaQuery.of(context).size.width * 0.9,
              //       blur: 15,
              //       gradient: LinearGradient(
              //         colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
              //         begin: Alignment.topLeft,
              //         end: Alignment.bottomRight,
              //       ),
              //       borderGradient: LinearGradient(
              //         colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.6)],
              //         begin: Alignment.topLeft,
              //         end: Alignment.bottomRight,
              //         stops: const [0.0, 0.39, 0.40, 1.0],
              //       ),
              //       borderWidth: 1.2,
              //       borderRadius: BorderRadius.circular(10),
              //       child: Column(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //             child: Column(
              //               children: [
              //                 TextScroll(
              //                   value.title,
              //                   velocity: const Velocity(pixelsPerSecond: Offset(80, 0)),
                                
              //                   selectable: true,
              //                 ),
              //                 TextScroll(
              //                   value.artist!,
              //                   velocity: const Velocity(pixelsPerSecond: Offset(80, 0)),
                               
              //                   selectable: true,
              //                 ),
                              
              //               ],
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 25),
              //             child: ValueListenableBuilder<ProgressBarState>(
              //               valueListenable: audioManager.progressNotifier,
              //               builder: (_, value,__) {
              //                 return ProgressBar(
              //                   progress: value.current,
              //                   buffered: value.buffered,
              //                   total: value.total,
              //                   onSeek: audioManager.seek,
              //                 );
              //               }
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              
              Positioned(
                bottom: 190,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0, sigmaY: 5.0
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white.withOpacity(0.6),
                        child: BlendMask(
                          blendMode: BlendMode.dstATop,
                          child: Text(
                            value.title,
                            style: const TextStyle(
                              color: Colors.white, 
                              fontSize: 48, fontWeight: FontWeight.w900, 
                              fontFamily: 'Poppins'
                            ), 
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ),
              ),

              Positioned(
                bottom: 30,
                child: BlurContainer(
                  borderRadius: BorderRadius.circular(25),
                  height: 70,
                  width: 300,
                  child: ValueListenableBuilder<ProgressBarState>(
                    valueListenable: audioManager.progressNotifier,
                    builder: (_, value, __) {
                      return ProgressBorder(
                        progress: getNormalizedValue(value.current, value.total), 
                        borderRadius: 25,
                        color: Colors.white,
                      );
                    }
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

class ProgressBorder extends StatelessWidget {
  final double progress;
  final double borderRadius;
  final Color color;

  const ProgressBorder({super.key, 
    required this.progress,
    required this.borderRadius,
    this.color = Colors.blue
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 100), // Tamaño del rectángulo
      painter: BorderProgressPainter(progress: progress, borderRadius: borderRadius, color: color),
      child: const PlayerControl( ),
    );
  }
}

class BorderProgressPainter extends CustomPainter {
  final double progress;
  final double borderRadius;
  final Color color;

  const BorderProgressPainter({
    this.progress = 0.5, 
    this.borderRadius = 10.0, 
    this.color = Colors.blue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Dibuja el borde gris del rectángulo con esquinas redondeadas
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );
    canvas.drawRRect(rrect, paint);

    // Dibuja el borde de progreso con esquinas redondeadas
    final progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final path = Path()..addRRect(rrect);
    final totalLength = path.computeMetrics().first.length;
    final progressLength = totalLength * progress;

    final progressMetric = path.computeMetrics().first;
    final extractPath = progressMetric.extractPath(0, progressLength);
    canvas.drawPath(extractPath, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
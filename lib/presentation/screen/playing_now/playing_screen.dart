import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/notifiers/progress_notifier.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:muix_player/util/util.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

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
      return 0.0;
    }

    // Normaliza la duración para que esté entre 0.0 y 1.0
    double normalizedValue = duration.inMilliseconds / maxDuration.inMilliseconds;

    // Asegúrate de que el valor esté limitado entre 0.0 y 1.0
    return normalizedValue.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final muixTheme = context.read<MuixTheme>();
    final size = MediaQuery.of(context).size;
    return ValueListenableBuilder<MediaItem>(
      valueListenable: audioManager.currentSongTitleNotifier,
      builder: (_,value, __) {
        return Scaffold(
          backgroundColor: Colors.transparent ,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LoadArtwork(
                    id: int.parse(value.id), 
                    artworkType: ArtworkType.AUDIO,
                    size: 1600,
                    quality: FilterQuality.high,
                    height: 360,
                    width: MediaQuery.of(context).size.width * 0.9,
                    radius: 20,
                  )
                ),
                const Positioned.fill(
                  child: BlurContainer()
                ),
                
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: size.height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                      )
                    ),
                    
                  ),
                ),
                Positioned(
                  top: 150,
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
                        Text('Playing Now', style: muixTheme.stPop30WhtW900),
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
                            child: Column(
                              children: [
                                Text(
                                  value.title,
                                  maxLines: 2,
                                  style: muixTheme.stPop48WhtW900,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20,),
                                Text(
                                  value.artist ?? "Desconocido",
                                  maxLines: 2,
                                  style: muixTheme.stPop20WhtW700,
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
                    opacity: 1,
                    height: 70,
                    width: 300,
                    color: const Color(0xff171a1e),
                    child: ValueListenableBuilder<ProgressBarState>(
                      valueListenable: audioManager.progressNotifier,
                      builder: (_, value, __) {
                        return ProgressBorder(
                          progress: value.current,
                          duration: value.total,
                          buffered: value.buffered,
                          progressColor: Colors.white, 
                          borderRadius: 25,
                          onSeek: (value) {
                            audioManager.seek(value);
                          },
                        );
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/notifiers/progress_notifier.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

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
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MediaItem>(
      valueListenable: audioManager.currentSongTitleNotifier,
      builder: (_,value, __) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const Background(),
              Positioned(
                top: 90.h,
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
              Positioned(
                bottom: 70.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GlassContainer(
                    height: 180.h,
                    width: MediaQuery.of(context).size.width * 0.9,
                    blur: 15,
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderGradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0.0, 0.39, 0.40, 1.0],
                    ),
                    borderWidth: 1.2,
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            children: [
                              TextScroll(
                                value.title,
                                velocity: const Velocity(pixelsPerSecond: Offset(80, 0)),
                                
                                selectable: true,
                              ),
                              TextScroll(
                                value.artist!,
                                velocity: const Velocity(pixelsPerSecond: Offset(80, 0)),
                               
                                selectable: true,
                              ),
                              
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: ValueListenableBuilder<ProgressBarState>(
                            valueListenable: audioManager.progressNotifier,
                            builder: (_, value,__) {
                              return ProgressBar(
                                progress: value.current,
                                buffered: value.buffered,
                                total: value.total,
                                onSeek: audioManager.seek,
                              );
                            }
                          ),
                        ),
                        const PlayerControl(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/notifiers/progress_notifier.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
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
    return Stack(
      children: [
        const Background(),

        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 300.h),
          painter: TopFigurePainter(),
        ),

        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Playing Now', style: AppMuixTheme.textUrbanistSemiBoldPrimary20),
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(), 
              icon: Iconify(Ic.round_chevron_left, 
                color: AppMuixTheme.background, 
                size: 35,
              )
            ),
            actions: [
              IconButton(
                onPressed: (){}, 
                icon: Iconify(Jam.menu, 
                  color: AppMuixTheme.background, 
                  size: 35,
                )
              ),

            ],
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: ValueListenableBuilder<MediaItem>(
              valueListenable: audioManager.currentSongTitleNotifier,
              builder: (_,value, __) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 260.h,
                            width: 260.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.white
                              ),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: QueryArtworkWidget(
                                id: int.parse(value.id),
                                type: ArtworkType.AUDIO,
                                keepOldArtwork: true,
                                artworkFit: BoxFit.cover,
                                artworkHeight: 260.h,
                                artworkWidth: 260.h,
                                artworkBorder: BorderRadius.circular(18),
                                artworkQuality: FilterQuality.high,
                                quality: 100,
                                size: 1600,
                              ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Column(
                              children: [
                                TextScroll(
                                  value.title,
                                  velocity: const Velocity(pixelsPerSecond: Offset(80, 0)),
                                  style: AppMuixTheme.textUrbanistSemiBoldPrimary32,
                                  selectable: true,
                                ),
                                Text(value.artist!, maxLines: 1,),
                                
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(onPressed: (){}, icon: const Iconify(Ph.download_bold, size: 30,)),
                                IconButton(onPressed: (){}, icon: const Iconify(Ri.equalizer_line, size: 30,)),
                                IconButton(onPressed: (){}, icon: const Iconify(Ph.heart, size: 30,))
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
                      
                    ],
                  ),
                );
              }
            ),
          ),
        ),
      ],
    );
  }
}

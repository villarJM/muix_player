import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/widgets/control_player/play_button.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BoxPlaying extends StatefulWidget {

  final double pBottom;
  
  const BoxPlaying({super.key, required this.pBottom});

  @override
  State<BoxPlaying> createState() => _BoxPlayingState();
}

class _BoxPlayingState extends State<BoxPlaying> {

  final audioManager = getIt<AudioManager>();
  final dominateColor = DominateColor();
  
  @override
  Widget build(BuildContext context){
    // final colorAdaptable = Provider.of<ColorAdaptable>(context);
    // final titleStyle = ThemeData.estimateBrightnessForColor(colorAdaptable.color) == Brightness.light 
    //   ? AppMuixTheme.textTitleUrbanistRegular16 
    //   : AppMuixTheme.textTitleUrbanistRegular16White;
    // final subtitleStyle = ThemeData.estimateBrightnessForColor(colorAdaptable.color) == Brightness.light 
    //   ? AppMuixTheme.textUrbanistBold16 
    //   : AppMuixTheme.textUrbanistBold16White;

    return Positioned(
      bottom: widget.pBottom,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ValueListenableBuilder<MediaItem>(
          valueListenable: audioManager.currentSongTitleNotifier,
          builder: (_, currentSong,__) {
            return ValueListenableBuilder<Color>(
              valueListenable: dominateColor.color,
              builder: (_, color, __) {
                return NowPlayingBar(
                  artwork: LoadArtwork(
                      id: int.parse(currentSong.id.isEmpty ? '0' : currentSong.id), 
                      artworkType: ArtworkType.AUDIO,
                      height: 70,
                    ), 
                  subtitle: Text("Subtitle", maxLines: 1), 
                  title: Text("Title", maxLines: 1),
                  icon: const PlayButton(customizableColor: true,)
                );
              }
            );
          }
        )
      )
    );
  }
}
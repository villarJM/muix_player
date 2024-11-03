import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/screen/playing_now/playing_screen.dart';
import 'package:muix_player/presentation/widgets/control_player/play_button.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/provider/color_adaptable.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

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
    final colorAdaptable = Provider.of<ColorAdaptable>(context);
    final muixTheme = context.read<MuixTheme>();
    final titleStyle = ThemeData.estimateBrightnessForColor(colorAdaptable.color) == Brightness.light 
      ? muixTheme.styleUrbanist16WhiteW500 
      : muixTheme.styleUrbanist16WhiteW500.copyWith(color: Colors.black);
    final subtitleStyle = ThemeData.estimateBrightnessForColor(colorAdaptable.color) == Brightness.light 
      ? muixTheme.styleUrbanist12WhiteW600 
      : muixTheme.styleUrbanist12WhiteW600.copyWith(color: Colors.black);

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
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PlayingScreen(),)
                    );
                  },
                  child: NowPlayingBar(
                    backgroundColor: colorAdaptable.color,
                    opacity: 0.4,
                    artwork: LoadArtwork(
                        id: int.parse(currentSong.id.isEmpty ? '0' : currentSong.id), 
                        artworkType: ArtworkType.AUDIO,
                        height: 70,
                      ), 
                    subtitle: Text("${currentSong.artist}", maxLines: 1, style: subtitleStyle,), 
                    title: Text(currentSong.title, maxLines: 1, style: titleStyle,),
                    icon: const PlayButton(customizableColor: true,)
                  ),
                );
              }
            );
          }
        )
      )
    );
  }
}
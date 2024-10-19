import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/screen/playing_now/playing_screen.dart';
import 'package:muix_player/presentation/widgets/control_player/play_button.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/provider/color_adaptable.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
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

    return Positioned(
      bottom: widget.pBottom,
      child: Container(
        height: 50.h,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ValueListenableBuilder<MediaItem>(
          valueListenable: audioManager.currentSongTitleNotifier,
          builder: (_, currentSong,__) {
            return ValueListenableBuilder<Color>(
              valueListenable: dominateColor.color,
              builder: (_, color, __) {
                return ListItem(
                  height: 50.h,
                  title: Text(currentSong.title, maxLines: 1, 
                  style: ThemeData.estimateBrightnessForColor(colorAdaptable.color) == Brightness.light ? AppMuixTheme.textTitleUrbanistRegular16 : AppMuixTheme.textTitleUrbanistRegular16White,),
                  subtitle: Text(currentSong.artist ?? "", maxLines: 1, style: ThemeData.estimateBrightnessForColor(colorAdaptable.color) == Brightness.light ? AppMuixTheme.textUrbanistBold16 : AppMuixTheme.textUrbanistBold16White,),
                  artwork: LoadArtwork(
                    id: int.parse(currentSong.id.isEmpty ? '0' : currentSong.id), 
                    artworkType: ArtworkType.AUDIO,
                    height: 70.h,
                  ),
                  onTap: ( ) => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const PlayingScreen(),
                    ),
                  ),
                  icon: const PlayButton(customizableColor: true,),
                  iconQueue: IconButton(
                    onPressed: (){}, 
                    icon: Iconify(IconParkOutline.music_menu, 
                      color: ThemeData.estimateBrightnessForColor(colorAdaptable.color) == Brightness.light ? AppMuixTheme.primary : Colors.white,
                    )
                  ),
                  enableIconQueue: true,
                  
                  borderRadius: BorderRadius.circular(10),
                  
                  imageBorderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(10), 
                    right: Radius.zero
                  ),
                  gradient: LinearGradient(
                    colors: [colorAdaptable.color.withOpacity(0.40), colorAdaptable.color],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
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
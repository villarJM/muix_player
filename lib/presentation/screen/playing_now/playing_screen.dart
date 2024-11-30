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

  @override
  Widget build(BuildContext context) {
    final audioManager = getIt<AudioManager>();
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
                const Background(),
                const Positioned.fill(
                  child: BlurContainer()
                ),
                positionedLinearGradient(size),
                positionedImage(value, context),
                positionedAppBar(context, muixTheme),
                positionedSongTitles(context, value, muixTheme),
                positionedProgressBorder()
              ],
            ),
          ),
        );
      }
    );
  }

  Positioned positionedSongTitles(BuildContext context, MediaItem value, MuixTheme muixTheme) {
    return Positioned(
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
    );
  }

  Positioned positionedAppBar(BuildContext context, MuixTheme muixTheme) {
    return Positioned(
      top: 10,
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlurContainer(
              borderRadius: BorderRadius.circular(15),
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: () => Navigator.pop(context), 
                icon: const Iconify(
                  Ic.round_chevron_left,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            Text('Playing Now', style: muixTheme.stPop30WhtW900),
            BlurContainer(
              borderRadius: BorderRadius.circular(15),
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: (){}, 
                icon: const Iconify(
                  Jam.menu,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned positionedImage(MediaItem value, BuildContext context) {
    return Positioned(
      top: 150,
      child: image(value, context)
    );
  }

  Positioned positionedLinearGradient(Size size) {
    return Positioned(
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
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter
          )
        ),
        
      ),
    );
  }

  Positioned positionedFullImage(MediaItem value, BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: image(value, context)
    );
  }

  LoadArtwork image(MediaItem value, BuildContext context) {
    return LoadArtwork(
      id: int.parse(value.id), 
      artworkType: ArtworkType.AUDIO,
      size: 1600,
      quality: FilterQuality.high,
      height: 360,
      width: MediaQuery.of(context).size.width * 0.9,
      radius: 20,
    );
  }

  Positioned positionedProgressBorder() {
    return Positioned(
      bottom: 30,
      child: BlurContainer(
        borderRadius: BorderRadius.circular(25),
        opacity: 0.11,
        height: 70,
        width: 300,
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
    );
  }
}
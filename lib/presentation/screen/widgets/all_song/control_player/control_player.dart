import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';

class ControlPlayer extends ConsumerStatefulWidget {

  final String path;
  final CarouselController controller;

  const ControlPlayer({
    Key? key,   
    required this.path,
    required this.controller,
  }) : super(key: key);

  @override
  ConsumerState<ControlPlayer> createState() => _ControlPlayerState();
}

class _ControlPlayerState extends ConsumerState<ControlPlayer> {

  PlayerState playerState = PlayerState.paused;
  @override
  Widget build(BuildContext context) {
    final audioState = ref.read(audioPlayerProvider);
    bool icon = ref.watch(isIconPlayer);
    IconData iconPlayer = ref.watch(iconPlayerChange);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {

          },
          icon: const Icon(Icons.shuffle_rounded, size: 40.0, color: Colors.white,shadows: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 1.0,
              color: Colors.black38
            )
          ]),
        ),
        IconButton(
          onPressed: () {
            widget.controller.previousPage();
          }, 
          icon: const Icon(Icons.skip_previous_rounded, size: 40.0, color: Colors.white, shadows: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 1.0,
              color: Colors.black38
            )
          ]),
        ),
        IconButton(
          onPressed: () {

            ref.read(isIconPlayer.notifier).state = !icon;
            ref.read(iconPlayerChange.notifier).state = icon ? Icons.play_arrow_rounded : Icons.pause_rounded;
            // icon = false => play, icon = true => pause
            icon ? audioState.pauseAudio() : audioState.playAudio(widget.path);
            playerState = icon ? PlayerState.paused : PlayerState.playing;
          }, icon: Icon(iconPlayer, size: 40.0, color: Colors.white, 
          
          shadows: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 1.0,
              color: Colors.black38
            )
          ], ),
        ),
        // button next
        IconButton(
          onPressed: () {
            // widget.controller.nextPage();
          }, 
          icon: const Icon(Icons.skip_next_rounded, size: 40.0, color: Color(0Xffffffff), shadows: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 1.0,
              color: Colors.black38
            )
          ]),
        ),
        IconButton(
          onPressed: () {

          }, icon: const Icon(Icons.repeat_rounded, size: 40.0, color: Color(0Xffffffff), shadows: [
            BoxShadow(

              offset: Offset(0, 2),
              blurRadius: 1.0,
              color: Colors.black38
            ),

          ], ),
        ),
      ],
    );
  }
}

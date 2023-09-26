import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/app/repositories/song_player_manager_repositories.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';

class ControlPlayer extends ConsumerStatefulWidget {

  final SongPlayerManager audioPlayerManager;
  final String path;

  const ControlPlayer({
    Key? key, 
    required this.audioPlayerManager,  
    required this.path
  }) : super(key: key);

  @override
  ConsumerState<ControlPlayer> createState() => _ControlPlayerState();
}

class _ControlPlayerState extends ConsumerState<ControlPlayer> {

  @override
  Widget build(BuildContext context) {

    bool icon = ref.read(isIconPlayer);
    IconData iconPlayer = ref.watch(iconPlayerChange);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {

          },
          icon: const Icon(Icons.shuffle_rounded, size: 40.0, color: Colors.white,),
        ),
        IconButton(
          onPressed: () {

          }, icon: const Icon(Icons.skip_previous_rounded, size: 40.0, color: Colors.white,)
        ),
        IconButton(
          onPressed: () {

            ref.read(isIconPlayer.notifier).state = !icon;
            ref.read(iconPlayerChange.notifier).state = icon ? Icons.play_arrow_rounded : Icons.pause_rounded;
            // icon = false => play, icon = true => pause
            icon ? widget.audioPlayerManager.pauseLocalAudio() : widget.audioPlayerManager.playLocalAudio(widget.path);

          }, icon: Icon(iconPlayer, size: 40.0, color: Colors.white),
        ),
        IconButton(
          onPressed: () {

          }, icon: const Icon(Icons.skip_next_rounded, size: 40.0, color: Colors.white,),
        ),
        IconButton(
          onPressed: () {

          }, icon: const Icon(Icons.repeat_rounded, size: 40.0, color: Colors.white,),
        ),
      ],
    );
  }
}

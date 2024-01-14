import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/presentation/providers/interactive_color_state_provider.dart';

class ControlPlayer extends ConsumerStatefulWidget {

  final String path;
  final Function()? onPressedRandom;
  final Function()? onPressedPrevious;
  final Function()? onPressedPlay;
  final Function()? onPressedNext;
  final Function()? onPressedRepeat;

  const ControlPlayer({
    Key? key,   
    required this.path,
    this.onPressedRandom,
    this.onPressedPrevious,
    this.onPressedPlay,
    this.onPressedNext,
    this.onPressedRepeat,
  }) : super(key: key);

  @override
  ConsumerState<ControlPlayer> createState() => _ControlPlayerState();
}

class _ControlPlayerState extends ConsumerState<ControlPlayer> {

  PlayerState playerState = PlayerState.paused;

  
  final boxShadow = const BoxShadow(
    offset: Offset(0, 2),
    blurRadius: 1.0,
    color: Colors.black38
  );

  @override
  Widget build(BuildContext context) {
    IconData iconPlayer = ref.watch(iconPlayerChange);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: widget.onPressedRandom,
          icon: Icon(Icons.shuffle_rounded, size: 40.0, color: Colors.black,
            shadows: [boxShadow]
          ),
        ),
        IconButton(
          onPressed: widget.onPressedPrevious, 
          icon: Icon(Icons.skip_previous_rounded, size: 40.0, color: Colors.black, 
            shadows: [boxShadow]
          ),
        ),
        ElevatedButton(
          onPressed: widget.onPressedPlay,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
            backgroundColor: ref.watch(interactiveColorProvider), // <-- Button color
            foregroundColor: Colors.white, // <-- Splash color
          ),
          child: Icon(iconPlayer, size: 40.0, color: Colors.black),
        ),
        // button next
        IconButton(
          onPressed: widget.onPressedNext, 
          icon: Icon(Icons.skip_next_rounded, size: 40.0, color: Colors.black, 
            shadows: [boxShadow]
          ),
        ),
        IconButton(
          onPressed: widget.onPressedRepeat, 
          icon: Icon(Icons.repeat_rounded, size: 40.0, color: Colors.black, 
            shadows: [boxShadow],
          ),
        ),
      ],
    );
  }
}

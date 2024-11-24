import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/notifiers/repeat_button_notifier.dart';
import 'package:muix_player/presentation/widgets/control_player/play_button.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';

class PlayerControl extends StatelessWidget {
const PlayerControl({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShuffleButton(), 
          PreviousButton(),
          PlayButton(),
          NextButton(),
          RepeatButton(),
          
        ],
      ),
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioManager = getIt<AudioManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: audioManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: const Iconify(Uim.previous, size: 50, color: Color(0xff9ca6ad),),
          highlightColor: Colors.white,
          onPressed: (isFirst) ? null : audioManager.previous,
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact
          ),
        );
      },
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioManager = getIt<AudioManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: audioManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Transform.rotate(
            angle: 3.15,
            child: const Iconify(Uim.previous, size: 50, color: Color(0xff9ca6ad))),
          onPressed: () {
            if (!isLast) {
              audioManager.next();
            }
          },
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact
          ),
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioManager = getIt<AudioManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: audioManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? const Iconify(Mi.shuffle, size: 24, color: Colors.white,)
              : const Iconify(Mi.shuffle, color:  Color(0xff9ca6ad), size: 24,),
          onPressed: audioManager.shuffle,
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact
          ),
        );
      },
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioManager = getIt<AudioManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: audioManager.repeatButtonNotifier, 
      builder: (context, value, child) {
        Widget icon;
        switch (value) {
          case RepeatState.off:
            icon = const Iconify(Mi.repeat, size: 24, color:  Color(0xff9ca6ad),);
            break;
          case RepeatState.repeatSong:
            icon = const Iconify(Mi.repeatOnce, size: 24, color:  Colors.white,);
            break;
          case RepeatState.repeatPlaylist:
            icon = const Iconify(Mi.repeat, size: 24, color:  Colors.white,);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: audioManager.repeat,
          style: IconButton.styleFrom(
            visualDensity: VisualDensity.compact
          ),
        );
      }
    );
  }
}
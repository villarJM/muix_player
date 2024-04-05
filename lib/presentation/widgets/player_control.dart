import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/notifiers/play_button_notifier.dart';
import 'package:muix_player/notifiers/repeat_button_notifier.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class PlayerControl extends StatelessWidget {
const PlayerControl({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
          icon: Transform.rotate(
          angle: 3.15,
          child: Iconify(Teenyicons.next_small_solid, color: AppMuixTheme.primary, size: 40,)),
            onPressed: (isFirst) ? null : audioManager.previous,
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
          icon: Iconify(Teenyicons.next_small_solid, color: AppMuixTheme.primary, size: 40,),
          onPressed: (isLast) ? null : audioManager.next,
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
              ? Iconify(Ph.shuffle_fill, color: AppMuixTheme.primary, size: 35,)
              : Iconify(Ph.shuffle_fill, color: AppMuixTheme.backgroundSecondary, size: 35,),
          onPressed: audioManager.shuffle,
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
            icon = const Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = Iconify(Ph.repeat_fill, color: AppMuixTheme.primary, size: 35,);
            break;
          case RepeatState.repeatPlaylist:
            icon = const Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: audioManager.repeat,
        );
      }
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final audioManager = getIt<AudioManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: audioManager.playButtonNotifier,
      builder: (_,value,__) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: const CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(onPressed: audioManager.play, icon: Iconify(Ri.play_fill, color: AppMuixTheme.primary, size: 50,));
          case ButtonState.playing:
            return IconButton(onPressed: audioManager.pause, icon: const Iconify(Ph.pause_fill));
        }
        
      }
    );
  }
}
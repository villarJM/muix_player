import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/notifiers/play_button_notifier.dart';
import 'package:muix_player/services/services.dart';

class PlayButton extends StatelessWidget {

  final bool customizableColor;
  const PlayButton({
    super.key,
    this.customizableColor = false,
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
            return IconButton(onPressed: audioManager.play, icon: const Iconify(Ri.play_fill, color: Color(0xff9ca6ad), size: 35,));
          case ButtonState.playing:
            return IconButton(onPressed: audioManager.pause, icon: const Iconify(Ph.pause_fill, color: Colors.white, size: 35,));
        }
      }
    );
  }
}
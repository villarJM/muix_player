import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/notifiers/play_button_notifier.dart';
import 'package:muix_player/provider/color_adaptable.dart';
import 'package:muix_player/services/services.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {

  final bool customizableColor;
  const PlayButton({
    super.key,
    this.customizableColor = false,
  });

  @override
  Widget build(BuildContext context) {
    final audioManager = getIt<AudioManager>();
    final colorAdaptable = Provider.of<ColorAdaptable>(context);
    final color = customizableColor ? (ThemeData.estimateBrightnessForColor(colorAdaptable.color) == Brightness.light ? Colors.white : Colors.white) : Colors.black;
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
            return IconButton(onPressed: audioManager.play, icon: Iconify(Ri.play_fill, color: color, size: 35,));
          case ButtonState.playing:
            return IconButton(onPressed: audioManager.pause, icon: Iconify(Ph.pause_fill, color: color, size: 35,));
        }
      }
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/notifiers/play_button_notifier.dart';
import 'package:muix_player/presentation/providers/color_state.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class PlayButton extends ConsumerWidget {

  final bool customizableColor;
  const PlayButton({
    super.key,
    this.customizableColor = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioManager = getIt<AudioManager>();
    final color = customizableColor ? (ThemeData.estimateBrightnessForColor(ref.watch(colorStateProvider)) == Brightness.light ? AppMuixTheme.primary : Colors.white) : AppMuixTheme.primary;
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
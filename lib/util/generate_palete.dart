import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/presentation/providers/interactive_color_state_provider.dart';
import 'dart:ui' as ui;

import 'package:muix_player/provider/song_local_provider.dart';
import 'package:palette_generator/palette_generator.dart';

class GeneratePalete {
  
  Future<void> getDominantingColorImageSong(int id, WidgetRef ref) async {
    final uint8list = await ref.watch(songLocalRepositoryProvider).getImage(id);
      ui.decodeImageFromList(uint8list, (result) async { 
        final PaletteGenerator generator = await PaletteGenerator.fromImage(result);
          final colorImage = generator.dominantColor!.color;
          ref.read(interactiveColorProvider.notifier).dominatingColor(colorImage);
        });
  }
}

import 'package:flutter/material.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:ui' as ui;

class ColorAdaptable extends ChangeNotifier {
  
  final offlineSongLocal = getIt<OfflineSongLocal>();
  Color _color = const Color(0xffe4d3b6);

  Color get color => _color;

  void getDominantingColorImage(int id, ArtworkType artworkType, int size, int? quality) async {
    final uint8list = await offlineSongLocal.getArtwork(id, artworkType, size, quality);
    ui.decodeImageFromList(uint8list, (result) async { 
      final PaletteGenerator generator = await PaletteGenerator.fromImage(result);
        final colorImage = generator.dominantColor!.color;
        _color = colorImage;
    });
    notifyListeners();
  }

}
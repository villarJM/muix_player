import 'package:flutter/material.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:ui' as ui;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_state.g.dart';


@Riverpod(keepAlive: true)
class ColorState extends _$ColorState {
  final offlineSongLocal = getIt<OfflineSongLocal>();

  @override
  Color build() => const Color(0xffe4d3b6);
  
  void getDominantingColorImage(int id, ArtworkType artworkType) async {
    final uint8list = await offlineSongLocal.getArtwork(id, artworkType);
      ui.decodeImageFromList(uint8list, (result) async { 
        final PaletteGenerator generator = await PaletteGenerator.fromImage(result);
          final colorImage = generator.dominantColor!.color;
          state = colorImage;
      });
  }
}
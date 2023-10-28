import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/domain/entities/song_local.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/provider/song_local_provider.dart';

class SongLocalService {

  final Ref ref;
  int index = 0;

  SongLocalService(this.ref);

  Future<void> updatedSongPosition(int position) async {
    index = position;
  }

  // Future<SongLocalModel> getSongLocalSlide(int songID) async {
  //   return 
  // }

  Future<void> getSongForID(int songID) async {
    final songLocal = ref.watch(songLocalRepositoryProvider).getSongLocal(10).asStream();
    
    SongLocalModel searchSong = SongLocalModel(
      id: 0, 
      title: '', 
      artist: '', 
      album: '', 
      gender: '', 
      duration: 0, 
      path: '',
      artwork: Uint8List(0)
    );
    songLocal.forEach((song) {
      searchSong = song.singleWhere((element) => element.id == songID);
      ref.read(songInfoNotifierProvider.notifier).songLocal(searchSong.id, searchSong.title, searchSong.artist, searchSong.album, searchSong.gender, searchSong.duration, searchSong.data);
      // searchSong.copyWith(id: searchSong.id, title: searchSong.title, artist: searchSong.artist, album: searchSong.album, genre: searchSong.gender, duration: searchSong.duration, data: searchSong.data);
    });
  }

  Future<void> getPositionSong(int state) async {
    final songLocal = ref.watch(songLocalRepositoryProvider).getSongLocal(10).asStream();
    final songPositions = songLocal.asyncMap((list) {
      return list.asMap();
    });
    
    songPositions.listen((mapa) {
      switch(state){
        case 1:
          preview(mapa);
          break;
        case 2:
          next(mapa);
          break;
      }
    });
  }

  Future<void> next(Map<int, SongLocalModel> listPositions) async {
    if (index < listPositions.length) {
      print('next');
      getSongForID(listPositions[index]!.id);
    }
    index++;
  }

  Future<void> preview(Map<int, SongLocalModel> listPositions) async {
    if (index > 0) {
      print('preview');
      getSongForID(listPositions[index]!.id);
    }
    index--;
  }

}
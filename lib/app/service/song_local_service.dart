import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/data/models/song_local_model.dart';
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

  Future<SongLocalModel> getSongForID(int songID) async {
    final songLocal = ref.watch(songLocalRepositoryProvider).getSongLocal().asStream();
    
    SongLocalModel searchSong = SongLocalModel(
      id: 0, 
      title: '', 
      artist: '', 
      album: '', 
      gender: '', 
      duration: 0, 
      path: '',
      position: 0,
    );
    songLocal.forEach((song) {
      searchSong = song.singleWhere((element) => element.id == songID);
      // ref.read(songInfoProvider.notifier).addSongInfo(searchSong);
      
    });
    return searchSong;
  }

  Future<SongLocalModel> getSongForPosition(int songPosition) async {

    final songLocal = ref.watch(songLocalRepositoryProvider).getSongLocal().asStream();

  await for (var element in songLocal) {
    if (element.isNotEmpty && songPosition >= 0 && songPosition < element.length) {
      return element.elementAt(songPosition);
    }
  }

  // Si el flujo está vacío o la posición no es válida, retorna un modelo vacío.
  return SongLocalModel(
    id: 0,
    title: '',
    artist: '',
    album: '',
    gender: '',
    duration: 0,
    path: '',
    position: 0
  );
  }

  Future<void> getPositionSong(int state) async {
    final songLocal = ref.watch(songLocalRepositoryProvider).getSongLocal().asStream();
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

  // Future<void> randomOrder(WidgetRef ref) async {
  //   Random random = Random();
  //   List<SongLocalModel> songList = await  ref.watch(songLocalRepositoryProvider).getSongLocal();
  //   songList.shuffle(random);
  //   for (int i = 0; i < songList.length; i++) {
  //   songList[i].position = i + 1;
  // }
  // }
}
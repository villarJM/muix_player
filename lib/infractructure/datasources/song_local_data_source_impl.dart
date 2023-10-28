import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:muix_player/data/datasources/song_local_data_source.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongLocalDataSourceImpl extends SongLocalDataSource{

  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Future<List<SongLocalModel>> getSongLocal([int? skipCount, int? maxResult]) async {
    List<SongLocalModel> songLocalList = [];
    List<SongModel> songs = await audioQuery.querySongs();
    
    if (maxResult != null && songs.length > maxResult) {
      
      songs = songs.sublist(skipCount!, maxResult+skipCount);
      return convertToSong(songs, songLocalList);
    }

    return convertToSong(songs, songLocalList);
  }
  
  @override
  Future<List<SongLocalModel>> getRecentlyAddedSongsLocal() async {
    List<SongModel> songs = await audioQuery.querySongs(sortType: SongSortType.DATE_ADDED, orderType: OrderType.ASC_OR_SMALLER );
    List<SongLocalModel> songLocalList = convertToSong(songs, []);
    int limit = 20;
    
    if (songLocalList.length > limit) {
      songLocalList = songLocalList.sublist(0, limit);
    }

    return songLocalList;
  }

  List<SongLocalModel> convertToSong(List<SongModel> songs, List<SongLocalModel> songLocalList) {
    for (var song in songs) {
      SongLocalModel songLocal = SongLocalModel.fromJson(song.getMap);
      songLocalList.add(songLocal);
    }
    return songLocalList;
  }

  @override
  Future<Uint8List> getImage(int id ) async {
    Uint8List? getImage = await audioQuery.queryArtwork(id, ArtworkType.AUDIO, size: 1800);
    if(getImage != null){
      return Uint8List.fromList(getImage);
    } else {
      return imageToUint8List('assets/images/placeholder_song.png');
    }
  }

  Future<List<SongLocalModel>> addImageSongLocal(List<SongLocalModel> songs) async {
    final newListSong = await Future.wait(
      songs.map((song) async {
        song.artwork = await getImage(song.id);
        return song;
      }).toList()
    );
    return newListSong;
  }
  
Future<Uint8List> imageToUint8List(String imagePath) async {
  // Carga la imagen desde la ruta del archivo
  ByteData data = await rootBundle.load(imagePath);
  Uint8List uint8List = data.buffer.asUint8List();
  return uint8List;
}
}
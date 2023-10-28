import 'dart:typed_data';

import 'package:muix_player/data/datasources/song_local_data_source.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/infractructure/datasources/song_local_data_source_impl.dart';

class SongLocalRepository implements SongLocalDataSource{

  final SongLocalDataSourceImpl songLocalDataSourceImpl;

  SongLocalRepository({required this.songLocalDataSourceImpl});


  @override
  Future<List<SongLocalModel>> getRecentlyAddedSongsLocal() {
    return songLocalDataSourceImpl.getRecentlyAddedSongsLocal();
  }

  @override
  Future<List<SongLocalModel>> getSongLocal([int? skipCount, int? maxResult]) {
    return songLocalDataSourceImpl.getSongLocal(skipCount, maxResult);
  }

  @override
  Future<Uint8List> getImage(int id) {
    return songLocalDataSourceImpl.getImage(id);
  }
  
  
}
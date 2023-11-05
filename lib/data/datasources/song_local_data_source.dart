
import 'dart:typed_data';

import 'package:muix_player/data/models/album_local_model.dart';
import 'package:muix_player/data/models/playlist_local_model.dart';
import 'package:muix_player/data/models/song_local_model.dart';

abstract class SongLocalDataSource {

  Future<List<SongLocalModel>> getSongLocal([int? skipCount, int? maxResult]);

  Future<List<PlaylistLocalModel>> getPlaylistLocal([int? maxResult]);

  Future<List<AlbumLocalModel>> getAlbumsLocal([int? maxResult]);

  Future<List<dynamic>> getArtistsLocal();

  Future<List<SongLocalModel>> getRecentlyAddedSongsLocal();

  Future<Uint8List> getImage(int id);

}
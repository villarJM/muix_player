
import 'dart:typed_data';

import 'package:muix_player/data/models/song_local_model.dart';

abstract class SongLocalDataSource {

  Future<List<SongLocalModel>> getSongLocal([int? skipCount, int? maxResult]);

  Future<List<SongLocalModel>> getRecentlyAddedSongsLocal();

  Future<Uint8List> getImage(int id);

}
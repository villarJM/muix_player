

import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/domain/entities/song_local.dart';

extension SongLocalMutable on SongLocal {
  
  SongLocal addSong(SongLocalModel song){
    return SongLocal(id: song.id, title: song.title, artist: song.artist, album: song.album, genre: song.gender, duration: song.duration, data: song.path, artwork: artwork);
  }
}
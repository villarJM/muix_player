import 'package:muix_player/data/models/song_local_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'song_info_state_provider.g.dart';

@Riverpod(keepAlive: true)
class SongInfo extends _$SongInfo {
  @override
  SongLocalModel build() => SongLocalModel(
    id: 0, 
    title: '', 
    artist: '', 
    album: '', 
    gender: '', 
    duration: 0, 
    path: '', 
    position: 0
  );

  void addSongInfo(SongLocalModel songLocalModel) => state = songLocalModel;  
}
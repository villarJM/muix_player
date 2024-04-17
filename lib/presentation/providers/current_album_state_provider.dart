
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_album_state_provider.g.dart';

class Album {
  final int id;
  final String album;
  final String artist;
  final int numOfSongs;
  final int year;
  final Map<dynamic, dynamic> getMap;

  Album(
    this.id, 
    this.album, 
    this.artist, 
    this.numOfSongs, 
    this.year,
    this.getMap,
  );
}

@Riverpod(keepAlive: true)
class CurrentAlbumStateProvider extends _$CurrentAlbumStateProvider {

  @override
  Album build() {
    return Album(0, '', '', 0, 0, {});
  }
  
  void selectedAlbum(Album album) {
    state = album;
  }
}
import 'package:muix_player/domain/datasources/song_post_datasources.dart';
import 'package:muix_player/domain/entities/song_post.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LocalSongsDatasource extends SongPostDatasources {
  
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Future<List<SongModel>> getSongFiles() async {
    List<SongModel> songs = await audioQuery.querySongs();
    return songs;
  }

  
  @override
  Future <List<SongPost>> convertToSongInfoList(List<SongModel> songs) async {
    return songs.map((song) {
      return SongPost(
        title: song.title,
        artist: song.artist,
        album: song.album,
        gender: song.genre,
      );
    }).toList();
  }

  @override
  Future<List<SongModel>> getRecentlyAddedSongs() async {
    List<SongModel> songs = await audioQuery.querySongs(sortType: SongSortType.DATE_ADDED, orderType: OrderType.ASC_OR_SMALLER );

    // List<SongModel> songRecently = [];
    
    int limit = 20;
  if (songs.length > limit) {
    songs = songs.sublist(0, limit);
  }
    return songs;
  }
  
}
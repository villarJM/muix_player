import 'package:muix_player/domain/entities/song_post.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class SongPostRepository {

  Future<List<SongModel>> getSongFiles();

  Future<List<SongPost>> convertToSongInfoList(List<SongModel> songs);

  Future<List<SongModel>> getRecentlyAddedSongs();
}
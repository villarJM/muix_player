import 'package:muix_player/domain/datasources/song_post_datasources.dart';
import 'package:muix_player/domain/entities/song_post.dart';
import 'package:muix_player/domain/repositories/song_post_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongPostRepositoriesImp implements SongPostRepository {

  final SongPostDatasources songsPostDatasources;

  SongPostRepositoriesImp({required this.songsPostDatasources});

  @override
  Future<List<SongPost>> convertToSongInfoList(List<SongModel> songs) {
    // TODO: implement convertToSongInfoList
    return songsPostDatasources.convertToSongInfoList(songs);
  }

  @override
  Future<List<SongModel>> getSongFiles() {
    // TODO: implement getSongFiles
    return songsPostDatasources.getSongFiles();
  }


}
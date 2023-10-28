
import 'package:muix_player/domain/entities/song_local.dart';

abstract class SongLocalRepository {

  Future<SongLocal> getSongLocal();

  Future<SongLocal> getRecentlyAddedSongsLocal();

}
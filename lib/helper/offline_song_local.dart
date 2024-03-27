import 'package:on_audio_query/on_audio_query.dart';

class OfflineSongLocal {
  static OnAudioQuery onAudioQuery = OnAudioQuery();

  Future<List<SongModel>> getSongs() async {
    return onAudioQuery.querySongs();
  }

  
}
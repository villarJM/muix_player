import 'package:flutter/services.dart';
import 'package:muix_player/util/util.dart';
import 'package:on_audio_query/on_audio_query.dart';

class OfflineSongLocal extends OnAudioQuery{
  static OnAudioQuery onAudioQuery = OnAudioQuery();

  Future<List<SongModel>> getSongs() async {
    return onAudioQuery.querySongs();
  }

  Future<List<AlbumModel>> getAlbums() async {
    return onAudioQuery.queryAlbums();
  }

  Future<List<ArtistModel>> getArtists() async {
    return onAudioQuery.queryArtists();
  }

  Future<List<GenreModel>> getGenres() async {
    return onAudioQuery.queryGenres();
  }

  Future<Uint8List> getArtwork(int id, ArtworkType artworkType) async {
    Uint8List? getImage = await onAudioQuery.queryArtwork(id, artworkType, size: 200);
    if(getImage != null) return Uint8List.fromList(getImage);
      return Image.imageToUint8List('assets/images/placeholder_song.png');
  }
}
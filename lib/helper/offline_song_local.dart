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

  Future<List<SongModel>> getSongsForAlbums(String album) async {
    final songs = await onAudioQuery.querySongs();
    return songs.where((item) => item.album == album).toList();
  }

  Future<List<ArtistModel>> getArtists() async {
    return onAudioQuery.queryArtists();
  }

  Future<List<SongModel>> getSongsForArtist(String artist) async {
    final songs = await onAudioQuery.querySongs();
    return songs.where((item) => item.artist == artist).toList();
  }

  Future<List<GenreModel>> getGenres() async {
    return onAudioQuery.queryGenres();
  }

  Future<List<String>> getAllPaths() async {
    return onAudioQuery.queryAllPath();
  }

  Future<List<PlaylistModel>> getPlaylists() async {
    return onAudioQuery.queryPlaylists();
  }

  Future<List<SongModel>> getAudiosFrom(AudiosFromType audiosFromType, Object where) async {
    return onAudioQuery.queryAudiosFrom(audiosFromType, where);
  }

  Future<bool> createPlayList(String namePlaylist) async {
    return onAudioQuery.createPlaylist(namePlaylist);
  }

  Future<bool> renamePlayList(int playlistId, String newName) async {
    return onAudioQuery.renamePlaylist(playlistId, newName);
  }

  Future<bool> deletePlayList(int playlistId) async {
    return onAudioQuery.removePlaylist(playlistId);
  }

  Future<List<SongModel>> getRecentlyAddedSongsLocal() async {
    final songs = await onAudioQuery.querySongs(sortType: SongSortType.DATE_ADDED, orderType: OrderType.ASC_OR_SMALLER);
    return songs.isNotEmpty ? songs.sublist(0, 20) : [];
  }

  Future<Uint8List> getArtwork(int id, ArtworkType artworkType, int size, int? quality) async {
    Uint8List? getImage = await onAudioQuery.queryArtwork(id, artworkType, size: size, quality: quality);
    if(getImage != null) return Uint8List.fromList(getImage);
      return Image.imageToUint8List('assets/images/placeholder_song.png');
  }

  Future<List<Uint8List>> getLisArtwork() async {
    final songs = await onAudioQuery.querySongs();
    List<Uint8List> listImage = [];

    for (var item in songs) {
      Uint8List? getImage = await onAudioQuery.queryArtwork(item.id, ArtworkType.AUDIO, size: 200);
      ByteData data = await rootBundle.load('assets/images/placeholder_song.png');
      Uint8List uint8List = data.buffer.asUint8List();
      final image = getImage ?? uint8List;
      
      listImage.add(image);
    }
    return listImage;
  }
}
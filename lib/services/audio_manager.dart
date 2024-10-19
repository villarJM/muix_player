import 'package:flutter/foundation.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/notifiers/play_button_notifier.dart';
import 'package:muix_player/notifiers/progress_notifier.dart';
import 'package:muix_player/notifiers/repeat_button_notifier.dart';
import 'package:audio_service/audio_service.dart';
import 'package:muix_player/services/services.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioManager {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = ValueNotifier<MediaItem>(const MediaItem(id: '', title: ''));
  final playlistNotifier = ValueNotifier<List<MediaItem>>([]);
  final songListNotifier = ValueNotifier<List<SongModel>>([]);
  final albumListNotifier = ValueNotifier<List<AlbumModel>>([]);
  final songsAlbumListNotifier = ValueNotifier<List<SongModel>>([]);
  final artistListNotifier = ValueNotifier<List<ArtistModel>>([]);
  final songsArtistListNotifier = ValueNotifier<List<SongModel>>([]);
  final genreListNotifier = ValueNotifier<List<GenreModel>>([]);
  final playlistListNotifier = ValueNotifier<List<PlaylistModel>>([]);
  final playlistCustomNotifier = ValueNotifier<List<SongModel>>([]);
  final recentlyListNotifier = ValueNotifier<List<SongModel>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);
  final _audioHandler = getIt<AudioHandler>();
  final offlineSongLocal = getIt<OfflineSongLocal>();

  // Events: Calls coming from the UI
  void init() async {
    await _loadPlaylist();
    await _loadAlbumList();
    await _loadArtistList();
    await _loadGenreList();
    await loadPlaylists();
    await _loadRecentlyAddedSongs();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
  }

  Future<void> _loadPlaylist() async {
    
    final playlist = await offlineSongLocal.getSongs();
    final mediaItems = transformToMediaItem(playlist);
    _audioHandler.addQueueItems(mediaItems);
    playlistNotifier.value = mediaItems;
    songListNotifier.value = playlist;
  }

  Future<void> _loadArtistList() async {
    final artistList = await offlineSongLocal.getArtists();
    artistListNotifier.value = artistList;
  }

  Future<void> _loadGenreList() async {
    final genreList = await offlineSongLocal.getGenres();
    genreListNotifier.value = genreList;
  }

  Future<void> _loadAlbumList() async {
    final albumList = await offlineSongLocal.getAlbums();
    albumListNotifier.value = albumList;
  }

  Future<void> loadAllAlbumList() async {
    List<List<MediaItem>> allAlbumsList = [];
    List<MediaItem> albumList = [];
    // final songs = songList.where((item) => item.album == albumList[index].album).toList();
    final songList = await offlineSongLocal.getSongs();
    final mediaItemList = transformToMediaItem(songList);
    final allAlbums = await offlineSongLocal.getAlbums();
    allAlbums.map(
      (e) {
        albumList = mediaItemList.where((song) => song.album == e.album).toList();
        allAlbumsList.add(albumList);
      }
    );
    _audioHandler.customAction('addAlbums', {"allAlbums": allAlbumsList});
  }

  Future<void> loadPlaylists() async {
      final playlist = await offlineSongLocal.getPlaylists();
      playlistListNotifier.value = playlist;
  }

  Future<void> loadPlaylist(AudiosFromType audiosFromType, Object where) async {
      final songList = await offlineSongLocal.getAudiosFrom(audiosFromType, where);
      playlistCustomNotifier.value = songList;
  }

  Future<void> loadSongsForAlbums(String album) async {
    songsAlbumListNotifier.value = await offlineSongLocal.getSongsForAlbums(album);
    final mediaItems = transformToMediaItem(songsAlbumListNotifier.value);
     await _audioHandler.updateQueue(mediaItems);
  }

  Future<void> loadSongsForArtist(String artist) async {
    songsArtistListNotifier.value = await offlineSongLocal.getSongsForArtist(artist);
  }

  Future<void> _loadRecentlyAddedSongs() async {
    recentlyListNotifier.value = await offlineSongLocal.getRecentlyAddedSongsLocal();
  }

  List<MediaItem> transformToMediaItem(List<SongModel> listSong) => listSong.map(
    (song) => MediaItem(
      id: song.id.toString(),
      album: song.album,
      title: song.title,
      artist: song.artist,
      genre: song.genre,
      extras: {
        'url': song.data,
      },
    )
  ).toList();
  
  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongTitleNotifier.value = const MediaItem(id: '', title: '');
      } else {
        final newList = playlist.map((item) => item).toList();
        playlistNotifier.value = newList;
      }
      _updateSkipButtons();
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongTitleNotifier.value = mediaItem ?? const MediaItem(id: '', title: '');
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void skipToNextQueueItem(int index) => _audioHandler.skipToQueueItem(index);
  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();

  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  void remove() {
    final lastIndex = _audioHandler.queue.value.length - 1;
    if (lastIndex < 0) return;
    _audioHandler.removeQueueItemAt(lastIndex);
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}



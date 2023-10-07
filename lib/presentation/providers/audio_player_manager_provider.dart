import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/domain/entities/song_post.dart';
import 'package:muix_player/presentation/providers/current_audio_info_notifier_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

// icon
final isIconPlayer = StateProvider((ref) => false);

final iconPlayerChange = StateProvider((ref) => Icons.play_arrow_rounded);

final listSongProvider = StateProvider<List<SongModel>>((ref) => []);

final positionNotifierProvider = StateNotifierProvider<PositionNotifier, int>((ref) {
  return PositionNotifier();
});

class PositionNotifier extends StateNotifier<int> {
  PositionNotifier() : super(0);

  void nextPosition() {
    state += 1;
  }
  void previewPosition() {
    state -= 1;
  }
  void setPosition(int? index){
    state = index!;
  }
  void updatePosition(int? index) {
    state = index!;
  }
}
final songInfoNotifierProvider = StateNotifierProvider<SongInfoNotifier, SongPost>((ref) {
  return SongInfoNotifier(SongPost(id: 0, title: '', artist: '', album: '', gender: '', duration: 0, path: '', position: 0));
});

class SongInfoNotifier extends StateNotifier<SongPost> {
  final LastSongListenPreference shared = LastSongListenPreference();
  SongInfoNotifier(SongPost state) : super(state);

  void songPost(int? id, String? title, String? artist, String? album, String? gender, int? duration, String? path, int? position) {
    state = SongPost(id: id!, title: title!, artist: artist, album: album, gender: gender, duration: duration, path: path!, position: position);
    _saveSharedPreferencesSongPost(id, title, artist, album, gender, duration, path, position);
  }

  void _saveSharedPreferencesSongPost(int? id, String? title, String? artist, String? album, String? gender, int? duration, String? path, int? position) {
    
    Map<String, dynamic> songData = {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'gender': gender ?? '',
      'path': path,
      'duration': duration,
      'position': position,
    };
    
      shared.saveData(songData);
  }
}

final audioPlayerProvider = ChangeNotifierProvider<AudioPlayerNotifier>((ref) {
  return AudioPlayerNotifier();
});

class AudioPlayerNotifier extends ChangeNotifier {

  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.paused;

  void playAudio(String url) async {
    await audioPlayer.play(DeviceFileSource(url));
    playerState = PlayerState.playing;
    notifyListeners();
  }

  void pauseAudio() {
    audioPlayer.pause();
    playerState = PlayerState.paused;
    notifyListeners();
  }

  void stopAudio() {
    audioPlayer.stop();
    playerState = PlayerState.stopped;
    notifyListeners();
  }

  void seekAudio(Duration position) {
    audioPlayer.seek(position);
    notifyListeners();
  }
}
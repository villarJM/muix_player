import 'package:audioplayers/audioplayers.dart';

class SongPlayerManager {
  final AudioPlayer audioPlayer = AudioPlayer();
  Stream<Duration> get onAudioPositionChanged =>
      audioPlayer.onPositionChanged;

  Future<void> playLocalAudio(String path) async {
    await audioPlayer.play(DeviceFileSource(path));
  }

  Future<void> pauseLocalAudio() async {
    await audioPlayer.pause();
  }

  Future<void> seekAudio(Duration position) async {
    await audioPlayer.seek(position);
  }
}
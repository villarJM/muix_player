import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

class SongPlayerManager {
  final AudioPlayer audioPlayer = AudioPlayer();
  Stream<Duration> get onAudioPositionChanged => audioPlayer.onPositionChanged;

  Future<void> playLocalAudio(String path) async {
    try {
      await audioPlayer.play(DeviceFileSource(path));
    } on FileSystemException catch (e) {
      throw FileSystemException('there was an error trying to read the file: $e');
    } on IOException catch (e) {
      e.toString();
    }
  }

  Future<void> pauseLocalAudio() async {
    await audioPlayer.pause();
  }

  Future<void> seekAudio(Duration position) async {
    await audioPlayer.seek(position);
  }
}
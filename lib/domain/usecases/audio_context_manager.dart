import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioContextManager {
  
  static AudioContext audioContext = const AudioContext();
  static AudioPlayer audioPlayer = AudioPlayer();

  static void playAudio(String source) async {
    try {
      await audioPlayer.play(DeviceFileSource(source));
    } catch (e) {
      debugPrintStack();
    }
  }

  static void pauseAudio() {
    audioPlayer.pause();
  }
}

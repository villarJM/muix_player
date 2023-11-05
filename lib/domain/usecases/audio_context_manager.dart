import 'package:audioplayers/audioplayers.dart';

class AudioContextManager {
  
  static AudioContext audioContext = const AudioContext();
  static AudioPlayer audioPlayer = AudioPlayer();

  static void playAudio(String source) async {
    try {
      await audioPlayer.play(DeviceFileSource(source));
    } catch (e) {
      print(e); 
    }
  }

  static void pauseAudio() {
    audioPlayer.pause();
  }
}

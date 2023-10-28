import 'package:muix_player/data/models/song_local_model.dart';

class SongPosition {

  final int currentPosition;
  final int nextPosition;
  final int previewPosition;
  final SongLocalModel songLocalModel;

  SongPosition({
    required this.currentPosition, 
    required this.nextPosition, 
    required this.previewPosition, 
    required this.songLocalModel
  });
}
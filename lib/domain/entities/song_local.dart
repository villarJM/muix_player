import 'dart:typed_data';

class SongLocal {
  final int id;
  final String title;
  final String artist;
  final String album;
  final String genre;
  final int duration;
  final String data;
  final Uint8List artwork;

  const SongLocal({
    required this.id, 
    required this.title, 
    required this.artist, 
    required this.album, 
    required this.genre, 
    required this.duration, 
    required this.data,
    required this.artwork,
  });
}
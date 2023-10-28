
import 'dart:typed_data';
import 'package:muix_player/domain/entities/song_local.dart';

class SongLocalModel extends SongLocal{
  final int id;
  final String title;
  final String artist;
  final String album;
  final String gender;
  final int duration;
  final String path;
  late Uint8List artwork;

  SongLocalModel({
    required this.id,
    required this.title, 
    required this.artist, 
    required this.album, 
    required this.gender,
    required this.duration,
    required this.path,
    required this.artwork,
  }) : super(id: id, title: title, artist: artist, album: album, genre: gender, duration: duration, data: path, artwork: artwork);

  factory SongLocalModel.fromJson(Map<dynamic, dynamic> json) => SongLocalModel(
    id: json["_id"], 
    title: json["title"], 
    artist: json["artist"], 
    album: json["album"], 
    gender: json["genre"] ?? "", 
    duration: json["duration"], 
    path: json["_uri"],
    artwork: Uint8List(0),
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "artist": artist,
      "album": album,
      "gender": gender,
      "duration": duration,
      "path": path,
      "artwork": artwork,
    };
  }

  
}
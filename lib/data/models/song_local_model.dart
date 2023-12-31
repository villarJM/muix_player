
import 'dart:typed_data';

class SongLocalModel {
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
  });

  factory SongLocalModel.fromJson(Map<dynamic, dynamic> json) => SongLocalModel(
    id: json["_id"], 
    title: json["title"], 
    artist: json["artist"], 
    album: json["album"], 
    gender: json["genre"] ?? "", 
    duration: json["duration"], 
    path: json["_data"],
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
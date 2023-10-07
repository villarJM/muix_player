

class SongPost {
  final int? id;
  final String title;
  final String? artist;
  final String? album;
  final String? gender;
  final int? duration;
  final String path;
  final int? position;

  SongPost({
    required this.id,
    required this.title, 
    required this.artist, 
    required this.album, 
    required this.gender,
    required this.duration,
    required this.path,
    required this.position,
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'gender': gender,
      'duration': duration,
      'path': path,
      'position': position,
    };
  }
}

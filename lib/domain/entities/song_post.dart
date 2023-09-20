

class SongPost {
  final String title;
  final String? artist;
  final String? album;
  final String? gender; 

  SongPost({
    required this.title, 
    required this.artist, 
    required this.album, 
    required this.gender,
  });


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'gender': gender,
    };
  }
}

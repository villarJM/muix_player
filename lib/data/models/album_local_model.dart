
class AlbumLocalModel{
  
  final int id;
  final String album;
  final String artist;
  final int artistId;
  final int numOfSongs;
  // final int year;
  // final String genre;

  AlbumLocalModel({
    required this.id, 
    required this.album, 
    required this.artist, 
    required this.artistId, 
    required this.numOfSongs
  });

  factory AlbumLocalModel.fromJson(Map<dynamic, dynamic> json) => AlbumLocalModel(
    id: json["_id"],  
    album: json["album"], 
    artist: json["artist"],
    artistId: json["artist_id"],
    numOfSongs: json["numsongs"],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "album": album,
      "artist": artist,
      "artistid": artistId,
      "numsongs": numOfSongs,
    };
  }
  
}
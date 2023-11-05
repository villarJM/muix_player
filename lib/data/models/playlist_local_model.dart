class PlaylistLocalModel {

  final int id;
  final String playlist;
  final String data;
  final int dateAdded;
  final int dateModified;
  final int numOfSongs;

  PlaylistLocalModel({
    required this.id, 
    required this.playlist, 
    required this.data, 
    required this.dateAdded, 
    required this.dateModified, 
    required this.numOfSongs
  });

  factory PlaylistLocalModel.fromJson(Map<dynamic, dynamic> json) => PlaylistLocalModel(
    id: json["_id"],  
    playlist: json["name"], 
    data: json["data"],
    dateAdded: json["date_added"],
    dateModified: json["date_modified"],
    numOfSongs: json["num_of_songs"],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "playlistname": playlist,
      "dateadded": dateAdded,
      "datemodified": dateModified,
      "numofsong": numOfSongs,
    };
  }
}
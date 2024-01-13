import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'song_info_state_provider.g.dart';

class SongTodo {
  final int id;
  final String title;
  final String artist;
  final String album;
  final int duration;
  final String path;
  final int position;

  SongTodo({
    required this.id, 
    required this.title,
    required this.artist,
    required this.album, 
    required this.duration, 
    required this.path, 
    required this.position
  });
}

@riverpod
class Todo extends _$Todo {
  @override
  SongTodo build() {
    return SongTodo(
      id: 0, 
      title: "", 
      artist: "", 
      album: "",  
      duration: 0, 
      path: "",
      position: 0,
    );
  }

  void addTodo(SongTodo songLocal) {
    state = songLocal;
  }
}
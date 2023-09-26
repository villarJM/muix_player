import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/app/repositories/song_player_manager_repositories.dart';

@immutable
class Todo {
  const Todo({
    required this.idSong, 
    required this.title, 
    required this.artist, 
    required this.path, 
    required this.duration, 
    required this.playerState,
    required this.songPlayerManager,
  });

  final int idSong;
  final String title;
  final String artist;
  final String path;
  final int duration;
  final PlayerState playerState;
  final SongPlayerManager songPlayerManager;
  

  Todo copyWith({int? idSong, String? title, String? artist, String? path, int? duration, PlayerState? playerState, SongPlayerManager? songPlayerManager}) {
    return Todo(
      idSong: idSong ?? this.idSong,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      path: path ?? this.path,
      duration: duration ?? this.duration,
      playerState: playerState ?? this.playerState,
      songPlayerManager: songPlayerManager ?? this.songPlayerManager,
    );
  }
}

class TodosNotifier extends StateNotifier<List<Todo>> {
  // We initialize the list of todos to an empty list
  TodosNotifier(): super([]);

  // Let's allow the UI to add todos.
  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  // Let's allow removing todos
  void removeTodo() {
    if(state.isNotEmpty){
      state.removeLast();
    }
  }

  // Let's mark a todo as completed
  void toggle(int todoId) {
    state = [
        if (state[0].idSong == todoId)
          state[0].copyWith(playerState: PlayerState.playing)
        else
          // other todos are not modified
          state[0],
    ];
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});
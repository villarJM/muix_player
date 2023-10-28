import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/data/models/song_local_model.dart';

@immutable
class Todo {
  const Todo(
    this.listSongLocalModel,
  );

  final List<SongLocalModel> listSongLocalModel;

  Todo copyWith({List<SongLocalModel>? listSongLocalModel}) {
    return Todo(
      listSongLocalModel ?? this.listSongLocalModel,
    );
  }
}

class TodosNotifier extends StateNotifier<List<SongLocalModel>> {

  TodosNotifier(): super([]);

  void addTodo(List<SongLocalModel> todo) {
    state = [...state, ...todo];
  }

  // Let's allow removing todos
  void removeTodo() {
    if(state.isNotEmpty){
      state.removeLast();
    }
  }

  // Let's mark a todo as completed
  // void toggle(int todoId) {
  //   state = [
  //       if (state[0].idSong == todoId)
  //         state[0].copyWith(playerState: PlayerState.playing)
  //       else
  //         // other todos are not modified
  //         state[0],
  //   ];
  // }
}

final todosStateNotifierProvider = StateNotifierProvider<TodosNotifier, List<SongLocalModel>>((ref) {
  return TodosNotifier();
});

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'song_info_state_provider.g.dart';

@Riverpod(keepAlive: true)
class Todo extends _$Todo {
  @override
  int build() => 0;

  void addPosition(int position) => state = position;

  void nextIncrement() => state++;

  void previousIncrement() => state--;
}
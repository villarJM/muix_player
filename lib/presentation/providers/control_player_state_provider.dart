import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'control_player_state_provider.g.dart';

@Riverpod(keepAlive: true)
class ControlPlayers extends _$ControlPlayers {
  @override
  int build() => 0;

  void addPosition(int position) => state = position;

  void nextIncrement() => state++;

  void previousIncrement() => state--;
}
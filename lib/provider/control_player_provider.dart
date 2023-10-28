import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/app/song_local_control_player.dart';
import 'package:muix_player/provider/song_local_service_provider.dart';

final shoppingCartItemControllerProvider = StateNotifierProvider<SongLocalControlPlayer, AsyncValue<void>>((ref) {
  return SongLocalControlPlayer(
    songLocalService: ref.watch(songLocalServiceProvider),
  );
});
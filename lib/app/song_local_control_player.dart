import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/app/service/song_local_service.dart';

class SongLocalControlPlayer extends StateNotifier<AsyncValue<void>>{

  final SongLocalService songLocalService;
  SongLocalControlPlayer({required this.songLocalService}) 
    : super(const AsyncData(null));

  Future<void> updatePositionSong(int position) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => songLocalService.updatedSongPosition(position)
    );

  }
}
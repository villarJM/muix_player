
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/app/service/song_local_service.dart';

final songLocalServiceProvider = Provider<SongLocalService>((ref) {
  return SongLocalService(ref);
});
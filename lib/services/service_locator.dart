import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:muix_player/helper/offline_song_local.dart';


import 'package:muix_player/services/services.dart';GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<OfflineSongLocal>(() => OfflineSongLocal());

  // page state
  getIt.registerLazySingleton<AudioManager>(() => AudioManager());
}

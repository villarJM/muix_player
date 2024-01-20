
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:muix_player/app/service/song_local_service.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/domain/usecases/audio_context_manager.dart';
import 'package:muix_player/presentation/providers/current_audio_info_notifier_provider.dart';
import 'package:muix_player/presentation/providers/interactive_background_image_state.dart';
import 'package:muix_player/presentation/providers/control_player_state_provider.dart';
import 'package:muix_player/presentation/providers/song_info_state_provider.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/control_player/control_player.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:muix_player/provider/song_local_service_provider.dart';
import 'package:muix_player/util/generate_palete.dart';
import 'package:muix_player/util/time_format.dart';

class PlayingNowScreen extends ConsumerStatefulWidget {

  static const String name = 'playing-now';
  const PlayingNowScreen({Key? key,}) : super(key: key);

  @override
  ConsumerState<PlayingNowScreen> createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends ConsumerState<PlayingNowScreen> {

  List<SongLocalModel> songList = [];
  late SongLocalService songLocalService;
  final LastSongListenPreference shared = LastSongListenPreference();

  GeneratePalete generatePalete = GeneratePalete();
  bool isLoadingPreferences = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
      return Stack(
        children: [
          Image.memory(
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            ref.watch(interactiveBackgroundImageProvider)
          ).blurred(
            blur: 40,
            blurColor: Colors.black,
            colorOpacity: 0.5,
          ),

          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Playing Now', style: TextStyle(color: Colors.black)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert, color: Colors.black,))
              ],
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,size: 40,)              
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView (
              child: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10,0, 100),
                          child: LoardArtwork(id: ref.watch(songInfoProvider).id, height: 600, width: MediaQuery.of(context).size.width, radius: 20),
                        ),
                        Positioned(
                          bottom: 0,
                          child: GlassContainer(
                            height: 200,
                            width: MediaQuery.of(context).size.width - 45,
                            gradient: LinearGradient(
                              colors: [Colors.white.withOpacity(0.20), Colors.white.withOpacity(0.10)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            borderGradient: LinearGradient(
                              colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: const [0.0, 0.39, 0.40, 1.0],
                            ),
                            blur: 15.0,
                            borderWidth: 1.5,
                            elevation: 3.0,
                            isFrostedGlass: true,
                            shadowColor: Colors.black.withOpacity(0.50),
                            alignment: Alignment.center,
                            frostedOpacity: 0,
                            margin: const EdgeInsets.all(8.0),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListTile(
                                  visualDensity: const VisualDensity(vertical: -3),
                                  title: Text(ref.watch(songInfoProvider).title, textAlign: TextAlign.center, overflow: TextOverflow.fade, maxLines: 1, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                                  subtitle: Text(ref.watch(songInfoProvider).artist, textAlign: TextAlign.center, overflow: TextOverflow.fade, maxLines: 1, style: const TextStyle(color: Colors.white)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: StreamBuilder(
                                    stream: AudioContextManager.audioPlayer.onPositionChanged,
                                    builder: (context, snapshots) {
                                      int currentPosition = snapshots.hasData ? snapshots.data!.inMilliseconds : 0;
                                      int totalDuration = ref.watch(songInfoProvider).duration;
                                      return Column(
                                        children: [
                                          Slider(
                                            activeColor: 
                                            Colors.black,
                                            inactiveColor: Colors.black,
                                            value: currentPosition.toDouble(),
                                            onChanged: (value) {
                                              AudioContextManager.audioPlayer.seek(Duration(milliseconds: value.toInt()));
                                            },
                                            min: 0.0,
                                            max: totalDuration.toDouble(),
                                          ),
                                            Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 25),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(TimeFormat.formatDuration(currentPosition)),
                                                Text(TimeFormat.formatDuration(totalDuration)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: ControlPlayer(
                                    path: ref.watch(songInfoProvider).path,
                                    onPressedRandom: () {},
                                    onPressedPrevious: () async {

                                      ref.watch(controlPlayersProvider.notifier).previousIncrement();
                                      
                                      final song = await ref.watch(songLocalServiceProvider).getSongForPosition(ref.watch(controlPlayersProvider));
                                      generatePalete.getImageSong(song.id, ref);
                                      generatePalete.getDominantingColorImageSong(song.id, ref);
                                      ref.read(songInfoProvider.notifier).addSongInfo(song);
                                    },
                                    onPressedPlay: () => AudioContextManager.playAudio(ref.watch(songInfoProvider).path),
                                    onPressedNext: () async {
                                      
                                      ref.read(controlPlayersProvider.notifier).nextIncrement();

                                      final song = await ref.watch(songLocalServiceProvider).getSongForPosition(ref.watch(controlPlayersProvider));
                                      generatePalete.getImageSong(song.id, ref);
                                      generatePalete.getDominantingColorImageSong(song.id, ref);
                                      ref.read(songInfoProvider.notifier).addSongInfo(song);
                                    },
                                    onPressedRepeat: () {},
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            )
          ),
        ],
      );
    }
  }
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:muix_player/app/service/song_local_service.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/presentation/providers/current_audio_info_notifier_provider.dart';
import 'package:muix_player/presentation/providers/song_info_state_provider.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/control_player/control_player.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:muix_player/provider/song_local_service_provider.dart';
import 'package:skeletons/skeletons.dart';

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

  bool isLoadingPreferences = false;
  String title = '';
  String artist = '';
  int duration = 0;
  String path = '';
  PlayerState playerState = PlayerState.paused;
  int length = 0;
  int position = -1;

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

    final audioState = ref.watch(audioPlayerProvider);

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Playing Now', style: TextStyle(color: Colors.black)),
          elevation: 0,
          backgroundColor: const Color(0Xffedf5f8),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert, color: Colors.black,))
          ],
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,size: 40,)              
          ),
        ),
        backgroundColor: const Color(0Xffedf5f8),
        body: SingleChildScrollView (
          child: SafeArea(
            child: Column(
              children: [
                FutureBuilder(
                  future: ref.watch(songLocalServiceProvider).getSongForPosition(ref.watch(todoProvider)),
                  builder:  (BuildContext context, AsyncSnapshot<SongLocalModel> snapshot) {
                    if (snapshot.hasData) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 10,0, 100),
                            child: LoardArtwork(id: snapshot.data!.id, height: 600, width: MediaQuery.of(context).size.width, radius: 20),
                          ),
                          Positioned(
                            bottom: 0,
                            child: GlassContainer(
                              height: 200,
                              width: MediaQuery.of(context).size.width - 45,
                              gradient: LinearGradient(
                                colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
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
                                    title: Text(snapshot.data!.title, textAlign: TextAlign.center, overflow: TextOverflow.fade, maxLines: 1, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                                    subtitle: Text(snapshot.data!.artist, textAlign: TextAlign.center, overflow: TextOverflow.fade, maxLines: 1, style: const TextStyle(color: Colors.white)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: StreamBuilder(
                                      stream: audioState.audioPlayer.onPositionChanged,
                                      builder: (context, snapshot) {
                                        return Slider(
                                          activeColor: Colors.black,
                                          inactiveColor: Colors.black,
                                          value: snapshot.hasData
                                              ? snapshot.data!.inMilliseconds.toDouble()
                                              : 0.0,
                                          onChanged: (value) {
                                            audioState.seekAudio(Duration(milliseconds: value.toInt()));
                                          },
                                          min: 0.0,
                                          max: duration.toDouble(),
                                        );
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('0:00'),
                                        Text('3:00'),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ControlPlayer(
                                      path: snapshot.data!.path,
                                      onPressedRandom: () {},
                                      onPressedPrevious: () => ref.watch(todoProvider.notifier).previousIncrement(),
                                      onPressedPlay: () {},
                                      onPressedNext: () => ref.watch(todoProvider.notifier).nextIncrement(),
                                      onPressedRepeat: () {},
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                        child: SkeletonAvatar(
                          style: SkeletonAvatarStyle(height: 600, width: MediaQuery.of(context).size.width, borderRadius: BorderRadius.circular(20)),
                        ),
                      );
                      // Center(child: CircularProgressIndicator(),);
                    }
                  }
                ),
              ],
            ),
          )
        )
      );
    }
  }
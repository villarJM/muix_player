import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:muix_player/app/service/song_local_service.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/domain/entities/song_local.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/presentation/providers/current_audio_info_notifier_provider.dart';
import 'package:muix_player/presentation/providers/song_info_state_provider.dart';
import 'package:muix_player/presentation/screen/all_songs/all_songs.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/control_player/control_player.dart';
import 'package:muix_player/presentation/screen/widgets/custom_playing.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:muix_player/provider/song_local_provider.dart';
import 'package:muix_player/provider/song_local_service_provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
  late CarouselController _controller;

  bool isLoadingPreferences = false;
  String title = '';
  String artist = '';
  int duration = 0;
  String path = '';
  PlayerState playerState = PlayerState.paused;
  int length = 0;
  int position = 0;

  @override
  void initState() {
    _controller = CarouselController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _getPosition();
    super.didChangeDependencies();
  }
  void _getPosition() {

    if (GoRouterState.of(context).extra != Null) {
      // final audio = ref.watch(todoProvider);
    }
    final data = GoRouterState.of(context).extra as Map<String, String>;
      if (data['position'] != null) {
        position = int.parse(data['position']!);
        
      }
    // });
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    final audioState = ref.watch(audioPlayerProvider);
    final audio = ref.watch(todoProvider);

      return Scaffold(
        backgroundColor: const Color(0Xffedf5f8),
        body: SingleChildScrollView (
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.goNamed('all-songs');
                      }, 
                      icon: const Icon(Icons.arrow_drop_up_rounded)              
                    ),
                  ],
                ),
                FutureBuilder(
                  future: ref.watch(songLocalServiceProvider).getSongForPosition(position),
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
                              width: 350,
                              gradient: LinearGradient(
                                colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              borderGradient: LinearGradient(
                                colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.lightBlueAccent.withOpacity(0.05), Colors.lightBlueAccent.withOpacity(0.6)],
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
                              frostedOpacity: 0.10,
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data!.title, textAlign: TextAlign.center, overflow: TextOverflow.fade, maxLines: 1),
                                    subtitle: Text(snapshot.data!.artist, textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: StreamBuilder(
                                      stream: audioState.audioPlayer.onPositionChanged,
                                      builder: (context, snapshot) {
                                        return Container(
                                          child: Slider(
                                            value: snapshot.hasData
                                                ? snapshot.data!.inMilliseconds.toDouble()
                                                : 0.0,
                                            onChanged: (value) {
                                              audioState.seekAudio(Duration(milliseconds: value.toInt()));
                                            },
                                            min: 0.0,
                                            max: duration.toDouble(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ControlPlayer(path: '', controller: _controller),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );



                    } else {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(20, 120, 20, 40),
                        child: const SkeletonAvatar(
                          style: SkeletonAvatarStyle(height: 340, width: 400),
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
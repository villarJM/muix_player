import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/presentation/providers/current_audio_info_notifier_provider.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/control_player/control_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingNowScreen extends ConsumerStatefulWidget {

  static const String name = 'playing-now';

const PlayingNowScreen({Key? key, }) : super(key: key);

  @override
  ConsumerState<PlayingNowScreen> createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends ConsumerState<PlayingNowScreen> {

    // shared preferences
  final LastSongListenPreference shared = LastSongListenPreference();
  final CarouselController _controller = CarouselController();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final ArtworkType artworkType = ArtworkType.AUDIO;

  bool isLoadingPreferences = false;
  String title = '';
  String artist = '';
  int duration = 0;
  String path = '';
  PlayerState playerState = PlayerState.paused;

  @override
  void initState() {
    super.initState();
    if (!isLoadingPreferences) {
      isLoadingPreferences = true;
      loadSharedPreferencesSongPost();
      _afterLayout();
    }
    
  }
    void _afterLayout() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToPageAfterCarouselLoaded();
    });
  }

  void _jumpToPageAfterCarouselLoaded() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.jumpToPage(ref.read(positionNotifierProvider));
    });
  }
    void loadSharedPreferencesSongPost() async {
    Map<String, dynamic> songData = await shared.getData();
    if(songData.isNotEmpty){
      ref.read(songInfoNotifierProvider.notifier).songPost(songData['id'], songData['title'], songData['artist'], songData['album'], songData['gender'], songData['duration'], songData['path'], songData['position']);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context){

    final songInfoProvider = ref.watch(songInfoNotifierProvider);
    final audioState = ref.watch(audioPlayerProvider);
    final songListProvider = ref.watch(listSongProvider);
    if (path.isEmpty) {
      title = songInfoProvider.title;
      artist = songInfoProvider.artist!;
      duration = songInfoProvider.duration!;
      path = songInfoProvider.path;
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            scrollPhysics: const BouncingScrollPhysics(),
            height: MediaQuery.of(context).size.height,
            viewportFraction:1.0,
            // cambia de pantalla
            onPageChanged: (index, reason) {
              final position =  ref.read(positionNotifierProvider);
              if(index > position){
                ref.read(positionNotifierProvider.notifier).nextPosition();
              } else if (index < position) {
                ref.read(positionNotifierProvider.notifier).previewPosition();
              }
            (int, SongModel) value = songListProvider.indexed.elementAt(index);
            ref.read(songInfoNotifierProvider.notifier).songPost(value.$2.id, value.$2.title, value.$2.artist, value.$2.album, value.$2.genre, value.$2.duration, value.$2.data, ref.read(positionNotifierProvider));
            ref.read(isIconPlayer.notifier).state = true;
            ref.read(iconPlayerChange.notifier).state = Icons.pause_rounded;
                if (audioState.playerState == PlayerState.playing) {
                  if (position < index) {
                    audioState.playAudio(value.$2.data);
                  }else{
                    audioState.playAudio(value.$2.data);
                  }
                } else {
                  playerState == PlayerState.playing ? audioState.pauseAudio() : audioState.playAudio(value.$2.data);
                }
            },
          ),
          items: songListProvider
          .map((song) {
            return Builder(
              builder: (BuildContext context) {
                title = song.title;
                artist = song.artist!;
                duration = song.duration!;
                path = song.data;
                return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      RepaintBoundary(
                        child: QueryArtworkWidget(
                          controller: _audioQuery,
                          id: song.id == 0 ? songInfoProvider.id!: song.id, 
                          type: artworkType,
                          artworkBorder: BorderRadius.circular(0),
                          artworkHeight: 600,
                          artworkWidth: 600,
                          size: 1800,
                          ),
                      ),
                      Positioned.fill(
                        top: 400,
                        child: Container(
                          decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                const Color(0XFF212345).withAlpha(0),
                                const Color(0XFF212345),
                                const Color(0XFF212345),
                                const Color(0XFF212345)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                                ),
                              ),
                        ),
                      ),
                    ],
                  );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(songInfoProvider.title == '' ? songListProvider.first.title : songInfoProvider.title, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
              Text( songInfoProvider.artist == '' ? songListProvider.first.artist! : songInfoProvider.artist!, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
            ]
          )
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 500, 0, 0),
          child: StreamBuilder(
              stream: audioState.audioPlayer.onPositionChanged,
              builder: (context, snapshot) {
                return Slider(
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
      
        Positioned(
          top: 35,
          left: 10,
          child: IconButton(onPressed: () {
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.chevron_left_rounded, color: Colors.white,)
          )
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: MediaQuery.of(context).size.height * 0.1,
          child: ControlPlayer(path: songInfoProvider.path, controller: _controller),
        ),
        ],        
      ),
    );
  }
}
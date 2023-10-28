import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/domain/entities/song_local.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/presentation/providers/current_audio_info_notifier_provider.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/control_player/control_player.dart';
import 'package:muix_player/presentation/screen/widgets/custom_playing.dart';
import 'package:muix_player/provider/song_local_provider.dart';
import 'package:muix_player/provider/song_local_service_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingNowScreen extends ConsumerStatefulWidget {

  static const String name = 'playing-now';

const PlayingNowScreen({Key? key, }) : super(key: key);

  @override
  ConsumerState<PlayingNowScreen> createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends ConsumerState<PlayingNowScreen> {

List<SongLocalModel> songList = [];
    // shared preferences

  late ScrollController _scrollController;
    late  PageController _pageController;
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
  int length = 0;

  @override
  void initState() {
    super.initState();
    if (!isLoadingPreferences) {
      isLoadingPreferences = true;
      // loadSharedPreferencesSongPost();
      // _afterLayout();
    }
    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _loadSongLocalList();
  }
    Future<void> _loadSongLocalList() async {
    List<SongLocalModel> songLocalList = await ref.watch(songLocalRepositoryProvider).getSongLocal();
    setState(() {
      songList = songLocalList;
    });
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
      // ref.read(songInfoNotifierProvider.notifier).songPost(songData['id'], songData['title'], songData['artist'], songData['album'], songData['gender'], songData['duration'], songData['path'], songData['position']);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  CustomPlaying _buildBody(SongLocal songLocal){
    return CustomPlaying();
  }
  @override
  Widget build(BuildContext context){

    final datos = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    final songInfoProvider = ref.watch(songInfoNotifierProvider);
    final songLocalList = ref.watch(songLocalRepositoryProvider).getSongLocal(10);
    final audioState = ref.watch(audioPlayerProvider);
    // final songListProvider = ref.watch(listSongProvider);
    // if (path.isEmpty) {
    //   title = songInfoProvider.title;
    //   artist = songInfoProvider.artist!;
    //   duration = songInfoProvider.duration!;
    //   path = songInfoProvider.path;
    // }
    return Scaffold(
      body: SingleChildScrollView (
        child: Column(
          children: [
            CarouselSlider(
              // carouselController: ,
              items: songList.map((song) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Image.memory(song.artwork)
                    ),
                  );

                }).toList(),
                options: CarouselOptions(
                  // Configura las opciones del carrusel según tus necesidades.
                  height: 700,
                  enlargeFactor: 0.0,
                  
                  viewportFraction: 0.9,
                  // enlargeCenterPage: true,
                  onScrolled: (value) {
                    
                  },
                  scrollDirection: Axis.horizontal,
                  
                ),
                ),
          ],
        )
        )
      );
      // Stack(
      //   alignment: Alignment.topCenter,
      //   children: [
      //     PageView.builder(
      //       itemCount: length,
      //       onPageChanged: (value) {
      //         ref.watch(songLocalServiceProvider).updatedSongPosition(value);
      //         _pageController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
      //       },
      //       itemBuilder: (context, index) {

      //         return Stack(
      //           alignment: Alignment.topCenter,
      //           children: [
      //             QueryArtworkWidget(
      //               controller: _audioQuery,
      //               id: songList[index].id, 
      //               type: artworkType,
      //               artworkBorder: BorderRadius.circular(0),
      //               artworkHeight: 600,
      //               artworkWidth: 600,
      //               size: 1800,
      //             ),
      //             Positioned.fill(
      //               top: 400,
      //               child: Container(
      //                 decoration: BoxDecoration(
      //                       gradient: LinearGradient(
      //                         colors: [
      //                       const Color(0XFF212345).withAlpha(0),
      //                       const Color(0XFF212345),
      //                       const Color(0XFF212345),
      //                       const Color(0XFF212345)
      //                     ],
      //                     begin: Alignment.topCenter,
      //                     end: Alignment.bottomCenter
      //                       ),
      //                     ),
      //               ),
      //             ),
      //           ]
      //         );
      //       },
      //     ),
      //   // CarouselSlider(
      //   //   carouselController: _controller,
      //   //   options: CarouselOptions(
      //   //     scrollPhysics: const BouncingScrollPhysics(),
      //   //     height: MediaQuery.of(context).size.height,
      //   //     viewportFraction:1.0,
      //   //     // cambia de pantalla
      //   //     onPageChanged: (index, reason) {
      //         // ref.watch(songLocalServiceProvider).updatedSongPosition(index);
      //       //   final position =  ref.read(positionNotifierProvider);
      //       //   if(index > position){
      //       //     ref.read(positionNotifierProvider.notifier).nextPosition();
      //       //   } else if (index < position) {
      //       //     ref.read(positionNotifierProvider.notifier).previewPosition();
      //       //   }
      //       // (int, SongModel) value = songListProvider.indexed.elementAt(index);
      //       // ref.read(songInfoNotifierProvider.notifier).songPost(value.$2.id, value.$2.title, value.$2.artist, value.$2.album, value.$2.genre, value.$2.duration, value.$2.data, ref.read(positionNotifierProvider));
      //       // ref.read(isIconPlayer.notifier).state = true;
      //       // ref.read(iconPlayerChange.notifier).state = Icons.pause_rounded;
      //       //     if (audioState.playerState == PlayerState.playing) {
      //       //       if (position < index) {
      //       //         audioState.playAudio(value.$2.data);
      //       //       }else{
      //       //         audioState.playAudio(value.$2.data);
      //       //       }
      //       //     } else {
      //       //       playerState == PlayerState.playing ? audioState.pauseAudio() : audioState.playAudio(value.$2.data);
      //       //     }
      //       // },
      //     // ),
      //     // items: 
      //     // .map((song) {
      //     //   return Builder(
      //     //     builder: (BuildContext context) {
      //     //       title = song.title;
      //     //       artist = song.artist;
      //     //       duration = song.duration;
      //     //       path = song.data;
      //     //       return Stack(
      //     //           alignment: Alignment.topCenter,
      //     //           children: [
      //     //             RepaintBoundary(
      //     //               child: QueryArtworkWidget(
      //     //                 controller: _audioQuery,
      //     //                 id: song.id, 
      //     //                 type: artworkType,
      //     //                 artworkBorder: BorderRadius.circular(0),
      //     //                 artworkHeight: 600,
      //     //                 artworkWidth: 600,
      //     //                 size: 1800,
      //     //                 ),
      //     //             ),
      //     //             Positioned.fill(
      //     //               top: 400,
      //     //               child: Container(
      //     //                 decoration: BoxDecoration(
      //     //                       gradient: LinearGradient(
      //     //                         colors: [
      //     //                       const Color(0XFF212345).withAlpha(0),
      //     //                       const Color(0XFF212345),
      //     //                       const Color(0XFF212345),
      //     //                       const Color(0XFF212345)
      //     //                     ],
      //     //                     begin: Alignment.topCenter,
      //     //                     end: Alignment.bottomCenter
      //     //                       ),
      //     //                     ),
      //     //               ),
      //     //             ),
      //     //           ],
      //     //         );
      //     //     },
      //     //   );
      //     // }).toList(),
      //   // ),
      //   Positioned.fill(
      //     child: GestureDetector(
      //           onHorizontalDragEnd: (details) {
      //             if (details.primaryVelocity! > 0) {  
      //               // Deslizar hacia la derecha (prev)
      //               // _pageController.previousPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
      //               // ref.watch(songLocalServiceProvider).getPositionSong(1);
      //             } else if (details.primaryVelocity! < 0) {
      //               // Deslizar hacia la izquierda (next)
      //               _pageController.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
      //               // ref.watch(songLocalServiceProvider).getPositionSong(2);
      //             }
      //           },
      //           child: Container(
      //             width: double.infinity,
      //             color: const Color.fromARGB(0, 117, 79, 79), // Asegúrate de que el GestureDetector cubra el Carousel
      //           ),
      //         ),
      //   ),
      //   Positioned(
      //     bottom: MediaQuery.of(context).size.height * 0.25,
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Text(title, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
      //         Text(artist, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
      //       ]
      //     )
      //   ),
      //   Padding(
      //     padding: const EdgeInsets.fromLTRB(0, 500, 0, 0),
      //     child: StreamBuilder(
      //         stream: audioState.audioPlayer.onPositionChanged,
      //         builder: (context, snapshot) {
      //           return Slider(
      //             value: snapshot.hasData
      //                 ? snapshot.data!.inMilliseconds.toDouble()
      //                 : 0.0,
      //             onChanged: (value) {
      //               audioState.seekAudio(Duration(milliseconds: value.toInt()));
      //             },
      //             min: 0.0,
      //             max: duration.toDouble(),
      //           );
      //         },
      //       ),
      //   ),
      
      //   Positioned(
      //     top: 35,
      //     left: 10,
      //     child: IconButton(onPressed: () {
      //         Navigator.pop(context);
      //       }, 
      //       icon: const Icon(Icons.chevron_left_rounded, color: Colors.white,)
      //     )
      //   ),
      //   Positioned(
      //     width: MediaQuery.of(context).size.width,
      //     bottom: MediaQuery.of(context).size.height * 0.1,
      //     child: ControlPlayer(path: path, controller: _controller),
      //   ),
      //   ],        
      // ),
  }
}
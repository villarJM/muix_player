import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/presentation/providers/song_info_state_notifier_provider.dart';
import 'package:muix_player/presentation/screen/playing_now/playing_now_screen.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:muix_player/presentation/widgets/custom_search_bar.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:muix_player/provider/song_local_provider.dart';
import 'package:muix_player/shared_preferences/last_song_listen_preference.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:skeletonizer/skeletonizer.dart';



class AllSongs extends StatelessWidget {

  // name router
  static const String name = 'all_songs';
  const AllSongs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: const Color.fromARGB(255, 33, 25, 110).withOpacity(1.0),
      key: scaffoldKey,
      body: const _ListSong(),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _ListSong extends ConsumerStatefulWidget{
  
  const _ListSong();

  @override
  ConsumerState<_ListSong> createState() => _GetAllSongState();
}

class _GetAllSongState extends ConsumerState<_ListSong> {

  final CarouselController carouselController = CarouselController();
  // shared preferences
  final LastSongListenPreference shared = LastSongListenPreference();

  List<SongLocalModel> _songList = <SongLocalModel>[];
  
  PlayerState playerState = PlayerState.stopped;

  final OnAudioQuery _audioQuery = OnAudioQuery();

  final ArtworkType artworkType = ArtworkType.AUDIO;
  int idSong = 0;
  String title = '';
  String? artist = '';
  String path = '';
  int? duration = 0;

  bool isPlaying = false;
  
  final _scrollController = ScrollController();

  int skipCount = 0;
  int maxResult = 12;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _loadSongLocalList();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> _loadSongLocalList() async {
    List<SongLocalModel> songLocalList = await ref.watch(songLocalRepositoryProvider).getSongLocal();
    setState(() {
      // skipCount = maxResult;
    _songList = songLocalList;
    ref.read(todosStateNotifierProvider.notifier).addTodo(songLocalList);
    });
  }
  

  Future<void> getPreferenceSong() async {
    Map<String, dynamic> songData = await shared.getData();
    if(songData.isNotEmpty){
      // ref.read(songInfoNotifierProvider.notifier).songPost(songData['id'], songData['title'], songData['artist'], songData['album'], songData['gender'], songData['duration'], songData['path'], songData['position']);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final songInfoProvider = ref.watch(todosStateNotifierProvider);
    if (songInfoProvider.isEmpty) {
      return const Center(child: CircularProgressIndicator(),);
    } else {
      return _widget(songInfoProvider);
    }
    
  }

  Route _createRoute(int id, String title, String artist, int duration, String path) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const PlayingNowScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      settings: RouteSettings(
        arguments: {
          'id': id,
          'title': title,
          'artist': artist,
          'duration': duration,
          'path': path,
        }
      ),
    );
}
  
  Widget _widget(List<SongLocalModel> listSongLocal){
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                elevation: 0,
                title: const Text('All of the song'),
                floating: true,
                flexibleSpace: Stack (
                  alignment: Alignment.center,
                  children: [
                    LoardArtwork(
                      id: idSong, 
                      width: 500, 
                      height: 500,
                      quality: FilterQuality.high,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                          const Color.fromARGB(255, 33, 25, 110).withOpacity(1.0),
                          const Color.fromARGB(255, 33, 25, 110).withOpacity(0.5),
                          const Color(0X19194EFF).withOpacity(0.0)
                          ],
                          begin: Alignment.bottomCenter, 
                          end: Alignment.topCenter,
                        )
                      ),
                    ),
                  ],
                ),
                expandedHeight: 400,
                centerTitle: true,
              ),
              
              SliverPersistentHeader(
                delegate: CustomSearchBar(),
                pinned: true,
              ),

              SliverList.builder(
                itemCount: _songList.length,
                itemBuilder: (context, index) {
                  if(_songList.isEmpty){
                    return const Center(child: LinearProgressIndicator());
                  } else {
                    final songTodo = listSongLocal[index];
                    // final songTodo = _songList[index];
                    return Container(
                      margin: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(25, 25, 78, 1),
                          borderRadius: BorderRadius.circular(5)
                        ),
                      child: ListTile(
                        title: Text(songTodo.title, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(songTodo.artist, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: LoardArtwork(id: songTodo.id, radius: 10,)),
                        onTap: () {
                          setState(() {
                            idSong = songTodo.id;
                            title = songTodo.title;
                            artist = songTodo.artist;
                            path = songTodo.data;
                            duration = songTodo.duration;
                          });
                        },
                      ),
                    );
                  }
                }
              )
            ],
          ),
        // Positioned(
        //     bottom: 0,
        //     // top: 0,
        //     left: 0,
        //     right: 0,
        //     child: Padding(
        //       padding: const EdgeInsets.all(0.0),
        //       child: Container(
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Colors.white),
        //           borderRadius: const BorderRadius.all(Radius.circular(21)),
        //         ),
        //         child: ListTile(
        //           title: Text(songInfoProvider.title == '' ? title : songInfoProvider.title, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
        //           subtitle: Text(songInfoProvider.artist == '' ? artist! : songInfoProvider.artist!, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
        //           leading: QueryArtworkWidget(
        //             controller: _audioQuery,
        //             id: songInfoProvider.id == 0 ? idSong : songInfoProvider.id!,
        //             type: ArtworkType.AUDIO,
        //             artworkBorder: BorderRadius.circular(10),
        //           ),
        //           trailing: IconButton(onPressed: () {
                    
        //             // change icon
        //             ref.read(isIconPlayer.notifier).state = !icon;
        //             ref.read(iconPlayerChange.notifier).state = icon ? Icons.play_arrow_rounded : Icons.pause_rounded;
        //             // icon = false => play, icon = true => pause
        //             icon ? audioState.pauseAudio() : audioState.playAudio(songInfoProvider.path == '' ? path : songInfoProvider.path);
        //             ref.read(audioPlayerProvider.notifier).playerState = playerState == PlayerState.playing ? PlayerState.paused : PlayerState.playing;
        //           }, icon: Icon(iconPlayer)),
        //           onTap: () {
        //             Navigator.of(context).push(_createRoute());
        //           },
        //         ).frosted(
        //           height: 70,
        //           width: MediaQuery.of(context).size.width,
        //           borderRadius: const BorderRadius.all(Radius.circular(20)),
        //           blur: 2.5,
        //         ),
        //       ),
              
        //     ),
        // ),
        ],
      ),
    );
  }
}
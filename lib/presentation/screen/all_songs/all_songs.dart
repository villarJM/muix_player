import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/infractructure/datasources/local_songs_datasource_impl.dart';
import 'package:muix_player/infractructure/repositories/song_post_repositories_impl.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/playing_now_screen.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:muix_player/shared_preferences/last_song_listen_preference.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:blur/blur.dart';
import 'package:audioplayers/audioplayers.dart';



class AllSongs extends StatelessWidget {

  // name router
  static const String name = 'all_songs';
  const AllSongs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
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


  final SongPostRepositoriesImp songs = SongPostRepositoriesImp(songsPostDatasources: LocalSongsDatasource());
  List<SongModel> _songList = [];
  
  PlayerState playerState = PlayerState.stopped;

  final OnAudioQuery _audioQuery = OnAudioQuery();

  final ArtworkType artworkType = ArtworkType.AUDIO;
  int idSong = 0;
  String title = '';
  String? artist = '';
  String path = '';
  int? duration = 0;

  bool isLoading = false;
  bool isPlaying = false;
  
  final _scrollController = ScrollController();
  double _searchBarTopPosition = 400;

  @override
  void initState() {
    super.initState();
    if (!isLoading) {
      _loadSongList();
      isLoading = true;
    } 
    // _scrollController.addListener(_scrollListener);
    getPreferenceSong();
  }
  
void _scrollListener() { 
    setState(() {
    _searchBarTopPosition = 400.0 - _scrollController.offset;
    if (_searchBarTopPosition < 35) {
        _searchBarTopPosition = 35;
    }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
  }

  Future<void> _loadSongList() async {
    List<SongModel> songList = await songs.getSongFiles();
    setState(() {
      _songList = songList;
    });
  }
  

  Future<void> getPreferenceSong() async {

    Map<String, dynamic> songData = await shared.getData();
    if(songData.isNotEmpty){
      ref.read(songInfoNotifierProvider.notifier).songPost(songData['id'], songData['title'], songData['artist'], songData['album'], songData['gender'], songData['duration'], songData['path'], songData['position']);
    }
    
  }
  @override
  Widget build(BuildContext context) {
    
    final songInfoProvider = ref.watch(songInfoNotifierProvider);
    final audioState = ref.watch(audioPlayerProvider);
    bool icon = ref.watch(isIconPlayer);
    IconData iconPlayer = ref.watch(iconPlayerChange);
    
    return Stack(
      alignment: Alignment.center,
      children: [
      CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          
          SliverAppBar(
            title: const Text('All of the song'),
            floating: true,
            flexibleSpace: Stack (
              alignment: Alignment.center,
              children: [
                QueryArtworkWidget(
                  controller: _audioQuery, 
                  id: idSong == 0 ? songInfoProvider.id! : idSong, 
                  type: artworkType, 
                  artworkQuality: FilterQuality.high,
                  artworkFit: BoxFit.cover,
                  format: ArtworkFormat.JPEG,
                  artworkBorder: const BorderRadius.all(Radius.circular(0)),
                  artworkHeight: 500,
                  artworkWidth: 500,
                  size: 1800,
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
          
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
                final audio = _songList[index];
                return Container(
                  margin: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(25, 25, 78, 1),
                      borderRadius: BorderRadius.circular(5)
                    ),
                  child: ListTile(
                    title: Text(audio.title, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                    subtitle: Text(audio.artist!, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                    leading: QueryArtworkWidget(
                      controller: _audioQuery,
                      id: audio.id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(10),
                    ),
                    onTap: () {

                        ref.read(positionNotifierProvider.notifier).setPosition(index);
                        shared.clearData();
                        ref.read(songInfoNotifierProvider.notifier).songPost(audio.id, audio.title, audio.artist, audio.album, audio.genre, audio.duration, audio.data, index);
                        setState(() {

                          idSong = audio.id;
                          title = audio.title;
                          artist = audio.artist;
                          path = audio.data;
                          duration = audio.duration;
                        });
                      ref.read(isIconPlayer.notifier).state = !icon;
                      ref.read(iconPlayerChange.notifier).state = Icons.pause_rounded;
                      audioState.playAudio(audio.data);
                      ref.read(audioPlayerProvider.notifier).playerState = PlayerState.playing;
                      playerState = audioState.playerState;
                    },
                  ),
                );
              },
              childCount: _songList.length,
            )
          ),
        ],
      ),
      // Positioned(
      //     top: _searchBarTopPosition,
      //     left: 0,
      //     right: 0,
      //     child: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: 
      //       const Text('Search...', style: TextStyle(color: Colors.white, fontSize: 18,),).frosted(
      //     height: 50,
      //     width: MediaQuery.of(context).size.width,
      //     borderRadius: BorderRadius.circular(5),
      //     blur: 2.5,
      //     ),
      //     ),
      //   ),
      Positioned(
          bottom: 0,
          // top: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(21)),
              ),
              child: ListTile(
                title: Text(songInfoProvider.title == '' ? title : songInfoProvider.title, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                subtitle: Text(songInfoProvider.artist == '' ? artist! : songInfoProvider.artist!, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                leading: QueryArtworkWidget(
                  controller: _audioQuery,
                  id: songInfoProvider.id == 0 ? idSong : songInfoProvider.id!,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(10),
                ),
                trailing: IconButton(onPressed: () {
                  
                  // change icon
                  ref.read(isIconPlayer.notifier).state = !icon;
                  ref.read(iconPlayerChange.notifier).state = icon ? Icons.play_arrow_rounded : Icons.pause_rounded;
                  // icon = false => play, icon = true => pause
                  icon ? audioState.pauseAudio() : audioState.playAudio(songInfoProvider.path == '' ? path : songInfoProvider.path);
                  ref.read(audioPlayerProvider.notifier).playerState = playerState == PlayerState.playing ? PlayerState.paused : PlayerState.playing;
                }, icon: Icon(iconPlayer)),
                onTap: () {
                  Navigator.of(context).push(_createRoute());
                },
              ).frosted(
                height: 70,
                width: MediaQuery.of(context).size.width,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                blur: 2.5,
              ),
            ),
            
          ),
      ),
    ],
    );
  }

  Route _createRoute() {
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
    );
}
}


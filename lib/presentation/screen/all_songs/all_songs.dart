import 'package:flutter/material.dart';
import 'package:muix_player/infractructure/datasources/local_songs_datasource_impl.dart';
import 'package:muix_player/infractructure/repositories/song_post_repositories_impl.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/playing_now_screen.dart';
import 'package:muix_player/presentation/screen/widgets/shared/linear_gradient_background.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:blur/blur.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:muix_player/app/repositories/song_player_manager_repositories.dart';



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

class _ListSong extends StatefulWidget {
  
  const _ListSong();

  @override
  State<_ListSong> createState() => _GetAllSongState();
}

class _GetAllSongState extends State<_ListSong> {

  final SongPostRepositoriesImp songs = SongPostRepositoriesImp(songsPostDatasources: LocalSongsDatasource());
  List<SongModel> _songList = [];

  SongPlayerManager audioPlayerManager = SongPlayerManager();
  PlayerState playerState = PlayerState.stopped;


  final OnAudioQuery _audioQuery = OnAudioQuery();

  final ArtworkType artworkType = ArtworkType.AUDIO;
  int idSong = 0;
  String title = '';
  String? artist = '';
  String path = '';
  int? duration = 0;

  static IconData iconChange = Icons.play_arrow_rounded;

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
    audioPlayerManager.audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      print(' state $state');
      setState(() {
        playerState = state;
      });
    });
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
  
  @override
  Widget build(BuildContext context) {

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
                  id: idSong, 
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
                      idSong = audio.id;
                      title = audio.title;
                      artist = audio.artist;
                      path = audio.data;
                      duration = audio.duration;
                      // playing
                      // iconChange = iconChange == Icons.play_arrow_rounded ? Icons.pause_rounded : Icons.play_arrow_rounded;
                      
                      setState(() {
                        
                      });
                      
                      iconChange = Icons.pause_rounded;
                      audioPlayerManager.playLocalAudio(path);
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
                title: Text(title, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                subtitle: Text(artist!, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                leading: QueryArtworkWidget(
                  controller: _audioQuery,
                  id: idSong,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(10),
                ),
                trailing: IconButton(onPressed: () {
                  
                  iconChange = iconChange == Icons.play_arrow_rounded ? Icons.pause_rounded : Icons.play_arrow_rounded;
                  setState(() {
                    
                  });
                  if(iconChange == Icons.pause_rounded){
                    audioPlayerManager.playLocalAudio(path);
                  } else if (iconChange == Icons.play_arrow_rounded){
                    audioPlayerManager.pauseLocalAudio();
                  } 
                }, icon: Icon(iconChange)),
                onTap: () {
                  Navigator.of(context).push(_createRoute(id: idSong, artist: artist!, title: title, artworkType: artworkType, duration: duration!, playerState: playerState, audioPlayerManager: audioPlayerManager));
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

  Route _createRoute({
    required int id, 
    required String artist, 
    required String title, 
    required ArtworkType artworkType, 
    required int duration, 
    required PlayerState playerState, 
    required audioPlayerManager
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayingNowScreen(
        id: id, 
        title: title, 
        artist: artist, 
        artworkType: artworkType, 
        duration: duration,
        playerState: playerState,
        audioPlayerManager: audioPlayerManager,
      ),
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


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/infractructure/datasources/local_songs_datasource_impl.dart';
import 'package:muix_player/infractructure/repositories/song_post_repositories_impl.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/presentation/providers/song_info_state_notifier_provider.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/playing_now_screen.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:muix_player/shared_preferences/last_song_listen_preference.dart';
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

class _ListSong extends ConsumerStatefulWidget{
  
  const _ListSong();

  @override
  ConsumerState<_ListSong> createState() => _GetAllSongState();
}

class _GetAllSongState extends ConsumerState<_ListSong> {

  // shared preferences
  final LastSongListenPreference shared = LastSongListenPreference();

  int spIdSong = 0;
  String spTitle = '';
  String spArtist = '';
  String spPath = '';
  int spDuration = 0;

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
      setState(() {
        playerState = state;
      });
      if (state == PlayerState.playing) {
        ref.read(todosProvider.notifier).toggle(spIdSong == 0 ? idSong : spIdSong);
      }
    });
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
      spIdSong = songData['idSong'];
      spTitle = songData['title'];
      spArtist = songData['artist'];
      spPath = songData['path'];
      spDuration = songData['duration'];

      ref.read(todosProvider.notifier).addTodo(Todo(idSong: spIdSong, title: spTitle, artist: spArtist, path: spPath, duration: spDuration, playerState: playerState, songPlayerManager: audioPlayerManager));
    }
    
  }
  @override
  Widget build(BuildContext context) {
    
    bool icon = ref.watch(isIconPlayer);
    IconData iconPlayer = ref.watch(iconPlayerChange);
    List<Todo> todos = ref.watch(todosProvider);
    
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
                  id: idSong == 0 ? spIdSong : idSong, 
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


                      
                      if (todos.isEmpty && idSong != audio.id) {

                        ref.read(todosProvider.notifier).removeTodo();
                        shared.clearData();
                        Map<String, dynamic> songData = {
                          'idSong': audio.id,
                          'title': audio.title,
                          'artist': audio.artist,
                          'path': audio.data,
                          'duration': audio.duration,
                        };
                        setState(() {
                          shared.saveData(songData);

                          idSong = audio.id;
                          title = audio.title;
                          artist = audio.artist;
                          path = audio.data;
                          duration = audio.duration;
                          playerState = PlayerState.playing;

                          spIdSong = 0;
                          spTitle = '';
                          spArtist = '';
                          spPath = '';
                          spDuration = 0;
                        });

                        ref.read(todosProvider.notifier).addTodo(Todo(idSong: audio.id, title: audio.title, artist: audio.artist!, path: audio.data, duration: audio.duration!, playerState: playerState, songPlayerManager: audioPlayerManager));

                      } else if (audio.id != todos[0].idSong) {

                        ref.read(todosProvider.notifier).removeTodo();
                        shared.clearData();
                        Map<String, dynamic> songData = {
                          'idSong': audio.id,
                          'title': audio.title,
                          'artist': audio.artist,
                          'path': audio.data,
                          'duration': audio.duration,
                        };
                        setState(() {
                          shared.saveData(songData);

                          idSong = audio.id;
                          title = audio.title;
                          artist = audio.artist;
                          path = audio.data;
                          duration = audio.duration;

                          spIdSong = 0;
                          spTitle = '';
                          spArtist = '';
                          spPath = '';
                          spDuration = 0;
                        });

                        ref.read(todosProvider.notifier).addTodo(Todo(idSong: audio.id, title: audio.title, artist: audio.artist!, path: audio.data, duration: audio.duration!, playerState: playerState, songPlayerManager: audioPlayerManager));

                      }
                      
                      ref.read(isIconPlayer.notifier).state = !icon;
                      ref.read(iconPlayerChange.notifier).state = Icons.pause_rounded;
                      audioPlayerManager.playLocalAudio(audio.data);
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
                title: Text(spTitle == '' ? title : spTitle, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                subtitle: Text(spArtist == '' ? artist! : spArtist, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)),
                leading: QueryArtworkWidget(
                  controller: _audioQuery,
                  id: spIdSong == 0 ? idSong : spIdSong,
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(10),
                ),
                trailing: IconButton(onPressed: () {
                  
                  // change icon
                  ref.read(isIconPlayer.notifier).state = !icon;
                  ref.read(iconPlayerChange.notifier).state = icon ? Icons.play_arrow_rounded : Icons.pause_rounded;
                  // icon = false => play, icon = true => pause
                  icon ? audioPlayerManager.pauseLocalAudio() : audioPlayerManager.playLocalAudio(spPath == '' ? path : spPath);
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


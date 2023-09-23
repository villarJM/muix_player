import 'package:flutter/material.dart';
import 'package:muix_player/infractructure/datasources/local_songs_datasource_impl.dart';
import 'package:muix_player/infractructure/repositories/song_post_repositories_impl.dart';
import 'package:muix_player/presentation/screen/widgets/shared/linear_gradient_background.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:blur/blur.dart';



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

  final OnAudioQuery _audioQuery = OnAudioQuery();

  final ArtworkType artworkType = ArtworkType.AUDIO;
  int idSong = 0;
  bool isLoading = false;
  
  final _scrollController = ScrollController();
  double _searchBarTopPosition = 400;

  @override
  void initState() {
    super.initState();
    if (!isLoading) {
      _loadSongList();
      isLoading = true;
    } 
    _scrollController.addListener(_scrollListener);
    
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
                  size: 1500,
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
                      setState(() {
                        
                      });
                    },
                  ),
                );
              },
              childCount: _songList.length,
            )
          ),
        ],
      ),
      Positioned(
          top: _searchBarTopPosition,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: 
            const Text('Search...', style: TextStyle(color: Colors.white, fontSize: 18,),).frosted(
          height: 50,
          width: MediaQuery.of(context).size.width,
          borderRadius: BorderRadius.circular(5),
          blur: 2.5,
          ),
          ),
        ),
    ],
    );
  }
}
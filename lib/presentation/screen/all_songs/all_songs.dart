import 'package:flutter/material.dart';
import 'package:muix_player/infractructure/datasources/local_songs_datasource_impl.dart';
import 'package:muix_player/infractructure/repositories/song_post_repositories_impl.dart';
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
  
  final _controller = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _loadSongList();
     // Setup the listener.
  _controller.addListener(() {
    if (_controller.position.hasPixels) {
      bool isTop = _controller.position.pixels <= 50;

      print(_controller.position.pixels);
      if (isTop) {
        print('At the top');
      } else {
        print('At the bottom');
      }
    }
  });
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
        controller: _controller,
        slivers: [
          SliverAppBar(
            title: const Text('All of the song'),
            floating: true,
            flexibleSpace:
            Padding(
              
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: QueryArtworkWidget(
                controller: _audioQuery, 
                id: idSong, 
                type: artworkType, 
                artworkQuality: FilterQuality.high,
                artworkFit: BoxFit.cover,
                format: ArtworkFormat.JPEG,
                quality: 100,
                artworkBorder: const BorderRadius.all(Radius.circular(0)),
                artworkHeight: 500,
                artworkWidth: 100,
                size: 1500,
              ),
            )
            ,
            expandedHeight: 400,
            centerTitle: true,
          ),
          SliverPersistentHeader(
            delegate: SearchBar(),
            pinned: true,
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
      
    ],
    );
  }
// Text('Search...', style: TextStyle(color: Colors.white, fontSize: 18,),).frosted(
//             height: 50,
//             width: MediaQuery.of(context).size.width,
//             borderRadius: BorderRadius.circular(5),
//             blur: 2.5,
//           ),


// Widget noAccessToLibraryWidget() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.redAccent.withOpacity(0.5),
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text("Application doesn't have access to the library"),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () => checkAndRequestPermissions(retry: true),
//             child: const Text("Allow"),
//           ),
//         ],
//       ),
//     );
//   }

}

class SearchBar extends SliverPersistentHeaderDelegate {
  
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final topPadding = MediaQuery.of(context).padding.top;
    return 
    Stack(
      children: [
        Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Container(
          color: Color.fromARGB(85, 255, 255, 255), // Color de fondo de la barra de búsqueda
          
        ).blurred(
          blur: 2.5,
          borderRadius: BorderRadius.circular(5),
        ),
        
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
      ],
      
    );
    // Container(
    //   padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
    //   decoration: BoxDecoration(
    //     // border: Border.all(
    //     //   color: Colors.white
    //     // ),
    //     borderRadius: BorderRadius.circular(6)
    //   ),
    //   child: const TextField(
    //     obscureText: true,
    //     textAlign: TextAlign.center,
    //     decoration: InputDecoration(
    //       hintStyle: TextStyle(color: Colors.white, fontSize: 18),
    //       border: InputBorder.none,
    //       hintText: 'Search...',
    //       contentPadding: EdgeInsets.fromLTRB(0, 15, 50, 0),
    //       prefixIcon: Padding(
    //         padding: EdgeInsetsDirectional.only(start: 5),
    //         child: Icon(Icons.search_outlined, color: Colors.white, size: 30,),
    //       )
    // )
    //   ).frosted(
    //     height: 100,
    //     width: MediaQuery.of(context).size.width,
    //     borderRadius: BorderRadius.circular(5),
    //     blur: 2.5,
    //   ),
    // );
  }
  
  @override
  double get maxExtent => 60;
  
  @override
  double get minExtent => 60;
  
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
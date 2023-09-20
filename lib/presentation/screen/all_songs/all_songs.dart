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
  
  @override
  void initState() {
    super.initState();
    _loadSongList();
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
        slivers: [
          SliverAppBar(
            title: const Text('All of the song'),
            floating: false,
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
      Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          
          decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.white
            // ),
            borderRadius: BorderRadius.circular(6)
          ),
          child: const TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white, fontSize: 18),
              border: InputBorder.none,
              hintText: 'Search...',
              contentPadding: EdgeInsets.fromLTRB(0, 15, 50, 0),
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 5),
                child: Icon(Icons.search_outlined, color: Colors.white, size: 30,),
              )
        )
          ).frosted(
            height: 50,
            width: MediaQuery.of(context).size.width,
            borderRadius: BorderRadius.circular(5),
            blur: 2.5,
          ),
        ),
      )
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
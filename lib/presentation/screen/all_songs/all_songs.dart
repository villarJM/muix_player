import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muix_player/domain/entities/song_post.dart';
import 'package:muix_player/infractructure/datasources/local_songs_datasource_impl.dart';
import 'package:muix_player/infractructure/repositories/song_post_repositories_impl.dart';
import 'package:muix_player/presentation/provider/list_provider.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';



class AllSongs extends StatelessWidget {

  // name router
  static const String name = 'all_songs';
  const AllSongs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All the songs')
      ),
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

    return Column(
      children: <Widget> [
        Expanded(
          flex: 1,
          child: SizedBox(
            width: double.infinity,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 5.0, // Ajusta la elevación del Card según tu preferencia
              child: Column(
                children: [
                  QueryArtworkWidget(controller: _audioQuery, id: idSong, type: artworkType, artworkFit: BoxFit.contain,)
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: _songList.length,
            itemBuilder: (context, index) {
              final audio = _songList[index];
              idSong = audio.id;

                return Container(
                  margin: const EdgeInsets.fromLTRB(10, 1, 10, 1),
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
                  ),
                );
            },
          ),
        ),

      ],
    );
  }



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
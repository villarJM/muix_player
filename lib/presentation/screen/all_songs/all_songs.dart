
import 'dart:typed_data';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/presentation/providers/song_info_state_provider.dart';
import 'package:muix_player/presentation/screen/playing_now/playing_now_screen.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:muix_player/presentation/widgets/custom_search_bar.dart';
import 'package:muix_player/presentation/widgets/custom_selected_song_box.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:muix_player/provider/song_local_provider.dart';
import 'package:muix_player/shared_preferences/last_song_listen_preference.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:ui' as ui;



class AllSongs extends ConsumerWidget {

  // name router
  static const String name = 'all-songs';
  const AllSongs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: const Color(0xffedf5f8),
      
      key: scaffoldKey,
      body: Stack(
        children: [
          // Container(
          //   decoration: const BoxDecoration(
          //     image: DecorationImage(image: AssetImage("assets/images/background1.jpg")),
          //   ),
          // ),
          const _ListSong(),
        ],
      ),
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
  final AudioPlayer audioPlayer = AudioPlayer();
  final CarouselController carouselController = CarouselController();
  // shared preferences
  final LastSongListenPreference shared = LastSongListenPreference();
  
  PlayerState playerState = PlayerState.stopped;

  final ArtworkType artworkType = ArtworkType.AUDIO;
  int idSong = 0;
  String title = '';
  String? artist = '';
  String path = '';
  int? duration = 0;
  int position = 0;

  bool isPlaying = false;
  Color colorImage = const Color(0XFF404094);
  Uint8List imagen = Uint8List.fromList([]);
  final _scrollController = ScrollController();

  int skipCount = 0;
  int maxResult = 12;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void loadColor(int id) {
    _generatePalette(id);
  }
  // ignore: unused_element
  Future<void> _generatePalette(int id) async {
    final uint8list = await ref.watch(songLocalRepositoryProvider).getImage(id);
      ui.decodeImageFromList(uint8list, (result) async { 
        final PaletteGenerator generator = await PaletteGenerator.fromImage(result);
        setState(() {
          imagen = uint8list;
          colorImage = generator.dominantColor!.color; 
        });
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
      return _widget();
  }

  Widget _widget(){
    return FutureBuilder(
      future: ref.watch(songLocalRepositoryProvider).getSongLocal(), 
      builder: (BuildContext context, AsyncSnapshot<List<SongLocalModel>> snapshot) {
        if (snapshot.hasData) {
           return SafeArea(
            child: Stack(
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
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if(snapshot.data!.isEmpty){
                          return const Center(child: LinearProgressIndicator());                 
                        } else {
                          final songTodo = snapshot.data![index];
                          return Card(
                            color: const Color(0xffedf5f8),
                            elevation: 3.0,
                            child: ListTile(
                              title: Text(songTodo.title, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black, fontSize: 12)),
                              subtitle: Text(songTodo.artist, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black, fontSize: 12)),
                              leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: LoardArtwork(id: songTodo.id, radius: 10,))),
                              onTap: () {
                                _generatePalette(songTodo.id);

                                ref.read(todoProvider.notifier).addTodo(SongTodo(
                                  id: songTodo.id, 
                                  title: songTodo.title, 
                                  artist: songTodo.artist, 
                                  album: songTodo.album,
                                  duration: songTodo.duration, 
                                  path: songTodo.path,
                                  position: index,

                                ));

                                setState(() {
                                  idSong = songTodo.id;
                                  title = songTodo.title;
                                  artist = songTodo.artist;
                                  path = songTodo.path;
                                  duration = songTodo.duration;
                                  position = index;
                                });
                              },
                            ),
                          );
                        }
                      }
                    )
                  ],
                ),
                CustomSelectedSongBox(
                  audioPlayer: audioPlayer, 
                  id: idSong, 
                  title: title, 
                  artist: artist!, 
                  path: path, 
                  color: colorImage,
                  onTap: () => context.goNamed('playing-now', extra: {'position': '$position'})
                )
              ],
            ),
                   );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}


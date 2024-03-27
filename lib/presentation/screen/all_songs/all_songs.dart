
import 'dart:typed_data';

import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/domain/usecases/audio_context_manager.dart';
import 'package:muix_player/presentation/providers/interactive_background_image_state.dart';
import 'package:muix_player/presentation/providers/interactive_color_state_provider.dart';
import 'package:muix_player/presentation/providers/control_player_state_provider.dart';
import 'package:muix_player/presentation/providers/song_info_state_provider.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:muix_player/presentation/widgets/custom_search_bar.dart';
import 'package:muix_player/presentation/widgets/custom_selected_song_box.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:muix_player/provider/song_local_provider.dart';
import 'package:muix_player/shared_preferences/last_song_listen_preference.dart';
import 'package:muix_player/util/generate_palete.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';



class AllSongs extends ConsumerWidget {

  // name router
  static const String name = 'all-songs';
  const AllSongs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.transparent,
      
      key: scaffoldKey,
      body: const Stack(
        children: [
          _ListSong(),
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

  GeneratePalete generatePalete = GeneratePalete();

  TextEditingController _textEditingController = TextEditingController();
  
  PlayerState playerState = PlayerState.stopped;

  late AudioContextManager audioContextManager;

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
  bool expandedHeight = true;
  String search = '';
  List<SongLocalModel> songList = [];

  int skipCount = 0;
  int maxResult = 12;

  @override
  void initState() {
    
    loadSong();
    convertImagetoUint8List();
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  void loadSong() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      songList = await ref.watch(songLocalRepositoryProvider).getSongLocal();
      setState(() {
        
      });
    });
  }
  Future<void> getPreferenceSong() async {
    Map<String, dynamic> songData = await shared.getData();
    if(songData.isNotEmpty){
      // ref.read(songInfoNotifierProvider.notifier).songPost(songData['id'], songData['title'], songData['artist'], songData['album'], songData['gender'], songData['duration'], songData['path'], songData['position']);
    }
  }
 Future<void> convertImagetoUint8List() async {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
    if (ref.watch(interactiveBackgroundImageProvider).isEmpty ) {
      final image = await generatePalete.imageToUint8List('assets/images/placeholder_song.png');
      ref.read(interactiveBackgroundImageProvider.notifier).getImage(image);
    }
  });
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: LoardArtwork(
                  id: songList[index].id,
                  radius: 10,
                ),
              )
            ),
            title: Text(songList[index].title),
            subtitle: Text(songList[index].album),
          );
        },
    );
    // return SafeArea(
    //   child: Stack(
    //     children: [
    //       Image.memory(
    //         fit: BoxFit.cover,
    //         height: MediaQuery.of(context).size.height,
    //         width: MediaQuery.of(context).size.width,
    //         ref.watch(interactiveBackgroundImageProvider)
    //       ).blurred(
    //         blur: 40,
    //         blurColor: ref.watch(interactiveColorProvider),
    //         colorOpacity: 0.8,
    //       ),
    //       CustomScrollView(
    //         slivers: <Widget>[
    //           SliverAppBar(
    //             backgroundColor: const Color(0xffedf5f8),
    //             shape: const RoundedRectangleBorder(
    //               borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(20.0),
    //                 bottomRight: Radius.circular(20.0),
    //               ),
    //             ),
    //             elevation: 0,
    //             title: const Text('All of the song'),
    //             floating: true,
    //             flexibleSpace: Stack (
    //               alignment: Alignment.center,
    //               children: [
    //                 LoardArtwork(
    //                   id: ref.watch(songInfoProvider).id, 
    //                   width: 500, 
    //                   height: 500,
    //                   quality: FilterQuality.high,
    //                   radius: 20,
    //                 ),
    //               ],
    //             ),
    //             expandedHeight: expandedHeight == true ? 400 : 0,
    //             centerTitle: true,
    //           ),
              
    //           SliverPersistentHeader(
    //             delegate: CustomSearchBar(
    //               textEditingController: _textEditingController,
    //               onChanged: (value) {
    //                 setState(() {
    //                   search = value;
                      
    //                 });
    //               },
    //               onTap: () {
    //                 setState(() {
    //                   expandedHeight = false;
    //                 });
    //               },
    //               onEditingComplete: () {
    //                 // setState(() {
    //                 //   expandedHeight = true;
    //                 // });
    //               },
    //             ),
    //             pinned: true,
    //           ),
            
    //           SliverList.builder(
    //             addAutomaticKeepAlives: true,
    //             itemCount: songList.length,
    //             itemBuilder: (context, index) {

    //                 final songTodo = songList[index];

    //                 return index == ref.watch(controlPlayersProvider) ? 
    //                 _cardSong(Colors.black12, songTodo, index) : 
    //                 _cardSong(Colors.transparent, songTodo, index);
    //             } 
    //           )
    //         ],
    //       ),
    //       CustomSelectedSongBox(
    //         id: ref.watch(songInfoProvider).id, 
    //         title: ref.watch(songInfoProvider).title, 
    //         artist: ref.watch(songInfoProvider).artist, 
    //         path: ref.watch(songInfoProvider).path, 
    //         color: ref.watch(interactiveColorProvider),
    //         onTap: () => context.push('/playing-now'),
    //         iconButton: IconButton(
    //           onPressed: () => AudioContextManager.playAudio(path),
    //           icon: const Icon(Icons.play_arrow)),
    //         artwork: SizedBox(
    //           height: 50,
    //           width: 50,
    //           child: Card(
    //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //             child: LoardArtwork(
    //               id: ref.watch(songInfoProvider).id,
    //               radius: 10,
    //             ),
    //           )
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget _cardSong(Color color, SongLocalModel songLocalModel, int index) {
    return Card(
      color: color,
      elevation: 0,
      child: ListTile(
        title: Text(songLocalModel.title, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900)),
        subtitle: Text(songLocalModel.artist, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 12)),
        leading: SizedBox(
          height: 50,
          width: 50,
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: LoardArtwork(id: songLocalModel.id, radius: 10,))),
        onTap: () {
          generatePalete.getDominantingColorImageSong(songLocalModel.id, ref);

          ref.read(controlPlayersProvider.notifier).addPosition(index);
          ref.read(songInfoProvider.notifier).addSongInfo(songLocalModel);

          setState(() {
            idSong = songLocalModel.id;
            title = songLocalModel.title;
            artist = songLocalModel.artist;
            path = songLocalModel.path;
            duration = songLocalModel.duration;
            position = index;
          });
        },
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/presentation/widgets/list_item.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Songs extends StatefulWidget {
const Songs({ Key? key }) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {

  List<SongModel> songsLoad = [];
  @override
  void initState() {
    loadSongs();
    super.initState();
  }

  Future<List<SongModel>> loadSongs() async {
    songsLoad = await OfflineSongLocal().getSongs();
    setState(() {});
    return songsLoad;
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: songsLoad.length,
        itemBuilder: (context, index) {
          final songs = songsLoad[index];
          return index % 2 == 0 ? 
          ListItem(
            title: Text(songs.title, maxLines: 1,),
            subtitle: Text(songs.artist ?? "", maxLines: 1,),
            artwork: QueryArtworkWidget(
              id: songs.id,
              type: ArtworkType.AUDIO,
              keepOldArtwork: true,
              artworkBorder: BorderRadius.circular(0),
              artworkFit: BoxFit.cover,
              artworkHeight: 100,
            ),
            borderRadiusTopLeft: 20,
            borderRadiusTopRight: 0,
            borderRadiusBottomLeft: 0,
            borderRadiusBottomRight: 20,
          ) : 
          ListItem(
            title: Text(songs.title, maxLines: 1,),
            subtitle: Text(songs.artist ?? "", maxLines: 1,),
            artwork: QueryArtworkWidget(
              id: songs.id,
              type: ArtworkType.AUDIO,
              keepOldArtwork: true,
              artworkBorder: BorderRadius.circular(0),
              artworkFit: BoxFit.cover,
              artworkHeight: 100,
            ),
            borderRadiusTopLeft: 0,
            borderRadiusTopRight: 20,
            borderRadiusBottomLeft: 20,
            borderRadiusBottomRight: 0,
          );
        },
      ) 
    );
  }
}
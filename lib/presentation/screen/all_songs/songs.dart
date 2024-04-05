import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/presentation/screen/playing_now/playing_screen.dart';
import 'package:muix_player/presentation/widgets/list_item.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../services/service_locator.dart';

class Songs extends StatefulWidget {
const Songs({ Key? key }) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {

  List<SongModel> songsLoad = [];
  final audioManager = getIt<AudioManager>();

  @override
  void initState() {
    // loadSongs();
    super.initState();
  }

  Future<List<SongModel>> loadSongs() async {
    songsLoad = await OfflineSongLocal().getSongs();
    // audioManager.loadPlaylist(songsLoad);
    setState(() {});
    return songsLoad;
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CupertinoScrollbar(
        
        child: ValueListenableBuilder<List<MediaItem>>(
          valueListenable: audioManager.playlistNotifier,
          builder: (context, playlistSongs,_) {
            return ListView.builder(
              itemCount: playlistSongs.length,
              itemBuilder: (context, index) {
                final songs = playlistSongs[index];
                return index % 2 == 0 ? 
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return PlayingScreen(id: int.parse(songs.id), title: songs.title, artist: songs.artist ?? "",);
                      },
                    ),
                  ),
                  child: ListItem(
                    title: Text(songs.title, maxLines: 1,),
                    subtitle: Text(songs.artist ?? "", maxLines: 1,),
                    artwork: QueryArtworkWidget(
                      id: int.parse(songs.id),
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
                  ),
                ) : 
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return PlayingScreen(id: int.parse(songs.id), title: songs.title, artist: songs.artist ?? "",);
                      },
                    ),
                  ),
                  child: ListItem(
                    title: Text(songs.title, maxLines: 1,),
                    subtitle: Text(songs.artist ?? "", maxLines: 1,),
                    artwork: QueryArtworkWidget(
                      id: int.parse(songs.id),
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
                  ),
                );
              },
            );
          }
        ),
      ) 
    );
  }
}
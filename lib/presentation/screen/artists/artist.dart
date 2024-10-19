import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/screen/artists/artists.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Artist extends StatefulWidget {
  const Artist({ Key? key }) : super(key: key);

  @override
  ArtistState createState() => ArtistState();
}

class ArtistState extends State<Artist> {

  final audioManager = getIt<AudioManager>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: ValueListenableBuilder<List<MediaItem>>(
        valueListenable: audioManager.playlistNotifier,
        builder: (_, songList, __) {
          return ValueListenableBuilder<List<AlbumModel>>(
            valueListenable: audioManager.albumListNotifier,
            builder: (_, albumList, __) {
              return ValueListenableBuilder<List<ArtistModel>>(
                valueListenable: audioManager.artistListNotifier,
                builder: (_, artistList, __) {
                  return ListView.builder(
                    itemCount: artistList.length,
                    itemBuilder: (context, index) {
                      final songListArtist = songList.where((item) => item.artist == artistList[index].artist).toList();
                      return InkWell(
                        onTap: () {
                          final songListAlbum = albumList.where((item) => item.artist == artistList[index].artist).toList();
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ArtistsDetailScreen(songList: songListArtist, albumList: songListAlbum,),
                            )
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 5.h),
                                    child: stackImage(songListArtist.take(3).toList(), artistList, index),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(artistList[index].artist, maxLines: 1, overflow: TextOverflow.clip,)),
                                    Expanded(child: Text('Albums: ${artistList[index].numberOfAlbums}')),
                                    Text('Tracks: ${artistList[index].numberOfTracks}'),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    
                    },
                  );
                }
              );
            }
          );
        }
      ),
    );
  }

  Stack stackImage(List<MediaItem> songListArtist, List<ArtistModel> artistList, int index) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        CircleAvatar(
         
          radius: 65,
          child: CircleAvatar(
            radius: 60,
            child: ClipOval(
              child: LoadArtwork(
                id: int.parse(songListArtist[0].id), 
                artworkType: ArtworkType.AUDIO,
                height: 100.h,
                width: 100.h,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
              ),
            ),
          ),
        ),

        Positioned(
          left: 65,
          child: CircleAvatar(
            radius: 65,
            child: CircleAvatar(
              radius: 60,
              child: ClipOval(
                child: LoadArtwork(
                 id: int.parse(songListArtist.length == 1 ? songListArtist[0].id : songListArtist[1].id),  
                  artworkType: ArtworkType.AUDIO,
                  height: 100.h,
                  width: 100.h,
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                ),
              ),
            ),
          ),
        ),

      Positioned(
        left: 130,
        child: CircleAvatar(
          radius: 65,
          child: CircleAvatar(
            radius: 60,
            child: ClipOval(
              child: LoadArtwork(
                id: int.parse((songListArtist.length == 1 || songListArtist.length == 2) ? songListArtist[0].id : songListArtist[2].id),  
                artworkType: ArtworkType.AUDIO,
                height: 100.h,
                width: 100.h,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
              ),
            ),
          ),
        ),
      ),

      Positioned(
        right: 0,
        child: CircleAvatar(
          radius: 65,
          child: CircleAvatar(
            radius: 60,
            child: Text('+${artistList[index].numberOfTracks}',),
          ),
        ),
      )
        
      ],
    );
  }
}
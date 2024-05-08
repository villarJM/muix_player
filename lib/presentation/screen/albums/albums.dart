import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/presentation/screen/albums/album.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Albums extends ConsumerStatefulWidget {
const Albums({ Key? key }) : super(key: key);

  @override
  ConsumerState<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends ConsumerState<Albums> {

  final offlineSongLocal = getIt<OfflineSongLocal>();
  final audioManager = getIt<AudioManager>();

  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ValueListenableBuilder<List<MediaItem>>(
        valueListenable: audioManager.playlistNotifier,
        builder: (_, songList, __) {
          return ValueListenableBuilder<List<AlbumModel>>(
            valueListenable: audioManager.albumListNotifier,
            builder: (context, albumList,_) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 7,
                  childAspectRatio: 0.8,
                ),
                
                controller: scrollController,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    
                    Map<dynamic, dynamic> album = {
                      'id': albumList[index].id,
                      'album': albumList[index].album,
                      'artist': albumList[index].artist,
                      'numOfSong': albumList[index].numOfSongs
                    };
                    final songs = songList.where((item) => item.album == albumList[index].album).toList();
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AlbumsDetailScreen(album, songs),
                      )
                    );
                  },
                  child: GlassContainer(
                    height: 260.h,
                    width: double.infinity,
                    blur: 5,
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderGradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0.0, 0.39, 0.40, 1.0],
                    ),
                    borderWidth: 1.2,
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        QueryArtworkWidget(
                          id: albumList[index].id,
                          type: ArtworkType.ALBUM,
                          artworkBorder: BorderRadius.circular(10),
                          artworkQuality: FilterQuality.high,
                          artworkFit: BoxFit.cover,
                          quality: 100,
                          artworkWidth: double.infinity,
                          artworkHeight: 120.h,
                          size: 1000,
                        ),
                        Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(albumList[index].album, maxLines: 1, overflow: TextOverflow.fade, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                            Row(
                              children: [
                                Expanded(child: Text(albumList[index].artist ?? "", maxLines: 1, overflow: TextOverflow.clip, style: AppMuixTheme.textUrbanistMediumPrimary12,),),
                                Text(' | 2023', maxLines: 1, overflow: TextOverflow.fade, textAlign: TextAlign.end, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                              ],
                            ),
                            Text('${albumList[index].numOfSongs} Songs', style: AppMuixTheme.textUrbanistMediumPrimary12,)
                          ],
                        ),
                      ),
                    )
                      ],
                    ),
                  ),
                ),       
              );
            }
          );
        }
      ),
    );
  }
}
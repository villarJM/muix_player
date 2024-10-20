import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/presentation/screen/albums/album.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';
import 'package:muix_player/presentation/widgets/load_artwork.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Albums extends ConsumerStatefulWidget {
const Albums({ Key? key }) : super(key: key);

  @override
  ConsumerState<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends ConsumerState<Albums> {

  final offlineSongLocal = getIt<OfflineSongLocal>();
  final audioManager = getIt<AudioManager>();

  late ScrollController scrollController;

  bool isExpand = false;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    // audioManager.loadAllAlbumList();
    final muixTheme = context.read<MuixTheme>();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: ValueListenableBuilder<List<MediaItem>>(
        valueListenable: audioManager.playlistNotifier,
        builder: (_, songList, __) {
          return ValueListenableBuilder<List<AlbumModel>>(
            valueListenable: audioManager.albumListNotifier,
            builder: (context, albumList,_) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlurContainer(
                        borderRadius: BorderRadius.circular(15),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isExpand = !isExpand;
                            });
                          }, 
                          icon: Iconify(isExpand ? Mi.minimize : Mi.expand, color: Colors.white,)
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Flexible(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isExpand ? 1 : 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.8,
                      ),
                      
                      controller: scrollController,
                      itemBuilder: (context, index) => InkWell(
                        borderRadius: BorderRadius.circular(isExpand ? 60 : 30),
                    
                        onTap: () {
                          Map<dynamic, dynamic> album = {
                            'id': albumList[index].id,
                            'album': albumList[index].album,
                            'artist': albumList[index].artist,
                            'numOfSong': albumList[index].numOfSongs
                          };
                          final songs = songList.where((item) => item.album == albumList[index].album).toList();
                          // audioManager.loadSongsForAlbums(albumList[index].album);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AlbumsDetailScreen(album, songs),
                            )
                          );
                        },
                        child: isExpand ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadiusDirectional.vertical(top: Radius.circular(60 )),
                                  child: LoadArtwork(
                                    id: albumList[index].id,
                                    artworkType: ArtworkType.ALBUM,
                                    radius: 0,
                                    quality: FilterQuality.high,
                                    width: double.infinity,
                                    height: 300,
                                    size: 1000,
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
                                Positioned(
                                  left: 20,
                                  bottom: 20,
                                  right: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BlurContainer(
                                        borderRadius: BorderRadius.circular(15),
                                        height: 40,
                                        width: 200,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Text(albumList[index].album, maxLines: 1, style: muixTheme.styleUrbanist20WhiteW700,),
                                          )
                                        ),
                                      ),
                                      BlurContainer(
                                        borderRadius: BorderRadius.circular(15),
                                        height: 40,
                                        width: 50,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Text("${albumList[index].numOfSongs}", maxLines: 1, style: muixTheme.styleUrbanist20WhiteW700,),
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            BlurContainer(
                              borderRadius: const BorderRadiusDirectional.vertical(bottom: Radius.circular(60)),
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: const Icon(Icons.favorite_border, color: Colors.white, size: 30,)
                                  ),
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: const Icon(Icons.play_circle_fill_outlined, color: Colors.white, size: 50,)
                                  ),
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: const Icon(Icons.more_vert, color: Colors.white, size: 30,)
                                  )
                                ],
                              ),
                            )
                          ],
                        ) :
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadiusDirectional.vertical(top: Radius.circular(30 )),
                                  child: LoadArtwork(
                                    id: albumList[index].id,
                                    artworkType: ArtworkType.ALBUM,
                                    radius: 0,
                                    quality: FilterQuality.high,
                                    width: double.infinity,
                                    height: 140,
                                    size: 1000,
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
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: BlurContainer(
                                      borderRadius: BorderRadius.circular(100),
                                      height: 60,
                                      width: 60,
                                      child: IconButton(
                                        onPressed: () {
                                          
                                        }, 
                                        icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40,)
                                      ),
                                    ),
                                  )
                                )
                              ],
                            ),
                            BlurContainer(
                              borderRadius: const BorderRadiusDirectional.vertical(bottom: Radius.circular(30)),
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(albumList[index].album, maxLines: 1, style: muixTheme.styleUrbanist12WhiteW600,)),
                                    IconButton(
                                      style: const ButtonStyle(
                                        padding: WidgetStatePropertyAll(EdgeInsets.zero)
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {}, 
                                      icon: const Icon(Icons.favorite_border, color: Colors.white, size: 25,)
                                    ),
                                    IconButton(
                                      style: const ButtonStyle(
                                        padding: WidgetStatePropertyAll(EdgeInsets.zero)
                                      ),
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {}, 
                                      icon: const Icon(Icons.more_vert, color: Colors.white, size: 25,)
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),       
                    ),
                  ),
                ],
              );
            }
          );
        }
      ),
    );
  }
}
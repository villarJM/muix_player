import 'package:anim_search_app_bar/anim_search_app_bar.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/presentation/screen/widgets/background.dart';
import 'package:muix_player/presentation/widgets/list_item.dart';
import 'package:muix_player/presentation/widgets/load_artwork.dart';
import 'package:muix_player/presentation/widgets/popup_menu_button_songs.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GenresDetailScreen extends StatefulWidget {
  final List<SongModel> songList;
  final List<AlbumModel> albumList;
  const GenresDetailScreen({ Key? key, required this.songList, required this.albumList }) : super(key: key);

  @override
  GenresDetailScreenState createState() => GenresDetailScreenState();
}

class GenresDetailScreenState extends State<GenresDetailScreen> {

  final TextEditingController searchController = TextEditingController();

  List<SongModel> songItems = [];
  
  void filterSearchResult(String query) {
    setState(() {
      songItems = widget.songList.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    songItems = widget.songList;
    super.initState();
  }

  @override
  void dispose() {
     // ignore: empty_catches
     try { searchController.dispose(); } catch (e) {}
    
    audioManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                AnimSearchAppBar(
                  cancelButtonText: "Cancel",
                  hintText: 'Search',
                  cSearch: searchController,
                  backgroundColor: Colors.transparent,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0
                      ),
                      
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    hintMaxLines: 1,
                    hintText: 'Search',
                    filled: true,
                    fillColor: AppMuixTheme.background,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0
                      ),
                    ),
                    
                  ),
                  onChanged: (value) {
                    filterSearchResult(value);
                  },
                  appBar: AppBar(
                    title: const Text('Search'),
                    backgroundColor: Colors.transparent,
                  )
                ),
                SizedBox(
                  height: 200.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      itemCount: widget.songList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: ValueListenableBuilder<List<MediaItem>>(
                            valueListenable: audioManager.playlistNotifier,
                            builder: (_, songList, __) {
                              return ValueListenableBuilder<List<AlbumModel>>(
                                valueListenable: audioManager.albumListNotifier,
                                builder: (context, albumList,_) {
                                  return ValueListenableBuilder<List<GenreModel>>(
                                    valueListenable: audioManager.genreListNotifier,
                                    builder: (context, genreList,_) {
                                      return InkWell(
                                        onTap: () {
                                          // Map<dynamic, dynamic> album = {
                                          //   'id': widget.albumList[index].id,
                                          //   'album': widget.albumList[index].album,
                                          //   'artist': widget.albumList[index].artist,
                                          //   'numOfSong': widget.albumList[index].numOfSongs,
                                          // };
                                          // final albums = songList.where((item) => item.album == albumList[index].album).toList();
                                          
                                          // Navigator.push(context, MaterialPageRoute(
                                          //     builder: (context) => AlbumsDetailScreen(album, albums),
                                          //   )
                                          // );
                                        },
                                        child: GlassContainer(
                                            height: 200.h,
                                            width: 172.w,
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
                                                LoadArtwork(
                                                  id: widget.songList[index].id, 
                                                  artworkType: ArtworkType.AUDIO,
                                                  height: 120.h,
                                                  width: 150.h,
                                                  size: 1800,
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
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                  child: Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text('${widget.songList[index].album}', maxLines: 1, overflow: TextOverflow.fade, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                                                        Row(
                                                          children: [
                                                            Expanded(child: Text(widget.songList[index].artist ?? "", maxLines: 1, overflow: TextOverflow.clip, style: AppMuixTheme.textUrbanistMediumPrimary12,),),
                                                            Text(' | 2023', maxLines: 1, overflow: TextOverflow.fade, textAlign: TextAlign.end, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                                                          ],
                                                        ),
                                                        Text('Songs', style: AppMuixTheme.textUrbanistMediumPrimary12,)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                      );
                                    }
                                  );
                                }
                              );
                            }
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: songItems.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ListItem(
                        height: 45.h,
                        title: Text(songItems[index].title, maxLines: 1,),
                        subtitle: Text(songItems[index].artist ?? "", maxLines: 1,),
                        artwork: LoadArtwork(
                          id: songItems[index].id, 
                          artworkType: ArtworkType.AUDIO,
                          height: 100.h,
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
                        onTap: () async {
                          audioManager..skipToNextQueueItem(index)..play();
                        },
                        icon: popupMenuButtonSongs(context, songItems[index].id),
                        
                        borderRadius: BorderRadius.circular(10.0),
                      );
                      
                        
                    },
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/presentation/screen/widgets/background.dart';
import 'package:muix_player/presentation/widgets/list_item.dart';
import 'package:muix_player/presentation/widgets/load_artwork.dart';
import 'package:muix_player/presentation/widgets/popup_menu_button_songs.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:anim_search_app_bar/anim_search_app_bar.dart';

class AlbumsDetailScreen extends ConsumerStatefulWidget {
  final Map<dynamic, dynamic> albumModel;
  final List<MediaItem> songList;
const AlbumsDetailScreen(this.albumModel, this.songList, { Key? key }) : super(key: key);

  @override
  ConsumerState<AlbumsDetailScreen> createState() => _AlbumsDetailScreenState();
}

class _AlbumsDetailScreenState extends ConsumerState<AlbumsDetailScreen>{

  final TextEditingController searchController = TextEditingController();

  List<MediaItem> songItems = [];
  
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
  Widget build(BuildContext context){
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
                GlassContainer(
                  height: 100.h,
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
                  borderRadius: BorderRadius.circular(10),
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      LoadArtwork(
                        id: widget.albumModel['_id'], 
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(widget.albumModel['album'], maxLines: 1, overflow: TextOverflow.clip,),
                              Text(widget.albumModel['artist'] ?? '', maxLines: 1, overflow: TextOverflow.clip,),
                              Text('Track: ${widget.albumModel['numsongs_by_artist']}'),
                              const Text('Duration: 4 minutos'),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            
                Expanded(
                  child: ListView.builder(
                    itemCount: songItems.length,
                    itemBuilder: (context, index) {
                      return ListItem(
                        height: 45.h,
                        title: Text(songItems[index].title, maxLines: 1,),
                        subtitle: Text(songItems[index].artist ?? "", maxLines: 1,),
                        artwork: LoadArtwork(
                          id: int.parse(songItems[index].id), 
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
                        icon: popupMenuButtonSongs(context, int.parse(songItems[index].id)),
                        
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
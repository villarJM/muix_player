import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/presentation/widgets/list_item.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class AlbumsDetailScreen extends ConsumerStatefulWidget {
  final Map<dynamic, dynamic> albumModel;
  final List<MediaItem> songList;
const AlbumsDetailScreen(this.albumModel, this.songList, { Key? key }) : super(key: key);

  @override
  ConsumerState<AlbumsDetailScreen> createState() => _AlbumsDetailScreenState();
}

class _AlbumsDetailScreenState extends ConsumerState<AlbumsDetailScreen>{

  final offlineSongLocal = getIt<OfflineSongLocal>();
  final audioManager = getIt<AudioManager>();
  

  @override
  Widget build(BuildContext context){
    return SuperScaffold(
      appBar: SuperAppBar(
        leading: Container(
          margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10),
          height: 35.w,
          width: 35.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 228, 211, 182),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10)
          ),
           child: IconButton(onPressed: () => Navigator.pop(context), icon: const Iconify(Jam.chevron_left)),
        ),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
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
                child: Row(
                  children: [
                    QueryArtworkWidget(
                      id: widget.albumModel['_id'], 
                      type: ArtworkType.ALBUM,
                      artworkHeight: 100.h,
                      artworkWidth: 100.h,
                      artworkBorder: BorderRadius.zero,
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
                  itemCount: widget.songList.length,
                  itemBuilder: (context, index) {
                    return ListItem(
                      title: Text(widget.songList[index].title, maxLines: 1,),
                      subtitle: Text(widget.songList[index].artist ?? "", maxLines: 1,),
                      artwork: QueryArtworkWidget(
                        id: int.parse(widget.songList[index].id),
                        type: ArtworkType.AUDIO,
                        keepOldArtwork: true,
                        artworkBorder: BorderRadius.circular(0),
                        artworkFit: BoxFit.cover,
                        artworkHeight: 100,
                      ),
                      onTap: () async {
                        audioManager..skipToNextQueueItem(index)..play();
                      },
                      icon: IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
                     
                      borderRadius: BorderRadius.only(
                        topLeft: index % 2 == 0 ? const Radius.circular(20) : Radius.zero,
                        topRight: index % 2 == 0 ? Radius.zero : const Radius.circular(20),
                        bottomLeft: index % 2 == 0 ? Radius.zero : const Radius.circular(20),
                        bottomRight: index % 2 == 0 ? const Radius.circular(20) : Radius.zero,
                      ),
                      imageBorderRadius: BorderRadius.only(
                        topLeft: index % 2 == 0 ? const Radius.circular(19) : Radius.zero,
                        topRight: index % 2 == 0 ? Radius.zero : const Radius.circular(19),
                        bottomLeft: index % 2 == 0 ? Radius.zero : const Radius.circular(19),
                        bottomRight: index % 2 == 0 ? const Radius.circular(19) : Radius.zero,
                      ),
                    );
                    
                      
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
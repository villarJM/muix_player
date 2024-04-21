import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({ Key? key }) : super(key: key);

  @override
  PlaylistScreenState createState() => PlaylistScreenState();
}

class PlaylistScreenState extends State<PlaylistScreen> {

  final offlineSongLocal = getIt<OfflineSongLocal>();
  final audioManager = getIt<AudioManager>();

  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ValueListenableBuilder<List<PlaylistModel>>(
        valueListenable: audioManager.playlistListNotifier,
        builder: (_, playlist, __) {
          return GridView.builder(
            itemCount: playlist.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 7,
              childAspectRatio: 0.8,
            ),
            
            controller: scrollController,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                
                // Navigator.pushReplacement(context, MaterialPageRoute(
                //     builder: (context) => AlbumsDetailScreen(albumList[index].getMap, songs),
                //   )
                // );
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index == 0 ? IconButton(
                      onPressed: (){
                        offlineSongLocal.createPlayList('playlist1');
                      }, 
                      icon: const Iconify(Teenyicons.add_solid, size: 45,)
                    )
                    : QueryArtworkWidget(
                        id: playlist[index].id,
                        type: ArtworkType.PLAYLIST,
                        artworkBorder: BorderRadius.circular(10),
                        artworkQuality: FilterQuality.high,
                        artworkFit: BoxFit.cover,
                        quality: 100,
                        artworkWidth: double.infinity,
                        artworkHeight: 120.h,
                        size: 1000,
                    ),
                    index == 0 ? Container()
                    :Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(playlist[index].playlist, maxLines: 1, overflow: TextOverflow.fade, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                            Text('${playlist[index].numOfSongs} Songs', style: AppMuixTheme.textUrbanistMediumPrimary12,)
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
      ),
    );
  }
}
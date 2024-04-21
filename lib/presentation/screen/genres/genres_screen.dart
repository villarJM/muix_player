import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({ Key? key }) : super(key: key);

  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {

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
      child: ValueListenableBuilder<List<GenreModel>>(
        valueListenable: audioManager.genreListNotifier,
        builder: (context, albumList,_) {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 7,
            shrinkWrap: true,
            childAspectRatio: 0.8,
            controller: scrollController,
            children: albumList.map((e) => InkWell(
              onTap: () async {
                // audioManager.songsAlbumListNotifier.value = await offlineSongLocal.getSongsForAlbums(e.album);
                // ref.watch(currentAlbumStateProviderProvider.notifier).selectedAlbum(Album(e.id, e.album, e.artist ?? '', e.numOfSongs, 2024, e.getMap));
                // ref.watch(tabStateProviderProvider.notifier).isSelected(true);

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
                      id: e.id,
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
                        Text(e.genre, maxLines: 1, overflow: TextOverflow.fade, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                        Text('Tracks: ${e.numOfSongs}', style: AppMuixTheme.textUrbanistMediumPrimary12,)
                      ],
                    ),
                  ),
                )
                  ],
                ),
              ),
            ),       
            ).toList(),
          );
        }
      ),
    );
  }
}
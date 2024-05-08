import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/presentation/screen/genres/genres.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
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
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ValueListenableBuilder<List<SongModel>>(
        valueListenable: audioManager.songListNotifier,
        builder: (context, songList,_) {
          return ValueListenableBuilder<List<AlbumModel>>(
            valueListenable: audioManager.albumListNotifier,
            builder: (context, albumList,_) {
              return ValueListenableBuilder<List<GenreModel>>(
                valueListenable: audioManager.genreListNotifier,
                builder: (context, genreList,_) {
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 7,
                    shrinkWrap: true,
                    childAspectRatio: 0.8,
                    controller: scrollController,
                    children: genreList.map((e) => InkWell(
                      onTap: () {
                        final songListGenre = songList.where((item) => item.genre == e.genre).toList();

                        // List<int> genreIds = genreList.map((genre) => genre.id).toList();
                        // List<AlbumModel> albumsFilteredByGenre = [];
                        // for (var album in albumList) {
                        //   if (songList.any((song) => genreIds.contains(null) )) {
                        //     albumsFilteredByGenre.add(album);
                        //   }
                        // }


                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => GenresDetailScreen(songList: songListGenre, albumList: [],),
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
                            LoadArtwork(
                              id: e.id, 
                              artworkType: ArtworkType.AUDIO,
                              height: 135.h,
                              width: 150.h,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Text(e.genre, maxLines: 1, overflow: TextOverflow.fade, style: AppMuixTheme.textUrbanistMediumPrimary12, textAlign: TextAlign.start,)),
                                ],
                              ),
                              Text('Tracks: ${e.numOfSongs}', style: AppMuixTheme.textUrbanistMediumPrimary12, textAlign: TextAlign.start)
                            ],
                          ),
                        )
                          ],
                        ),
                      ),
                    ),       
                    ).toList(),
                  );
                }
              );
            }
          );
        }
      ),
    );
  }
}
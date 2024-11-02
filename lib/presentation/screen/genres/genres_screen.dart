import 'package:flutter/material.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/presentation/screen/genres/genres.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({ Key? key }) : super(key: key);

  @override
  GenresScreenState createState() => GenresScreenState();
}

class GenresScreenState extends State<GenresScreen> {

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
    final muixTheme = context.read<MuixTheme>();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
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
                      borderRadius: BorderRadius.circular(25),
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
                            builder: (context) => GenresDetailScreen(songList: songListGenre, albumList: const [],),
                          )
                        );
                      },
                      child: BlurContainer(
                        borderRadius: BorderRadius.circular(25),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            LoadArtwork(
                              id: e.id, 
                              artworkType: ArtworkType.AUDIO,
                              height: 135,
                              width: 150,
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
                            Positioned(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: Text(e.genre, maxLines: 1, overflow: TextOverflow.fade,  textAlign: TextAlign.start, style: muixTheme.styleUrbanist12WhiteW600,)),
                                      ],
                                    ),
                                    Text('Tracks: ${e.numOfSongs}',  textAlign: TextAlign.start, style: muixTheme.styleUrbanist12WhiteW600,)
                                  ],
                                ),
                              ),
                            ),
                          ]
                        )
                      )
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
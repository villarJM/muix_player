import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:skeletons/skeletons.dart';

class CustomCardCarouselCircle extends ConsumerWidget {


  final double height;
  final double viewportFraction;
  final bool isEnLargeCenterPage;
  final double marginHorizontal;
  final double borderRadio;
  final bool isCircle;
  final Future<List<SongLocalModel>> songRecently;

  const CustomCardCarouselCircle({
    super.key, 
    required this.height,
    required this.viewportFraction, 
    required this.isEnLargeCenterPage,
    required this.marginHorizontal, 
    required this.borderRadio,
    required this.isCircle,
    required this.songRecently
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return FutureBuilder(
      future: songRecently, 
      builder: (BuildContext context, AsyncSnapshot<List<SongLocalModel>> snapshot) {
        if (snapshot.hasData) {
          return CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 0.6,
              pageSnapping: true,
              height: height,
              enlargeCenterPage: isEnLargeCenterPage,
              viewportFraction: viewportFraction
            ),
            items: snapshot.data!.map((song) {
              return Column(
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadio)
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            LoardArtwork(id: song.id, width: 200, height: 90, radius: borderRadio, artworkType: ArtworkType.AUDIO,),
                          ],
                        ),
                      );
                    },
                  ),
                  Text(song.artist, style: const TextStyle(fontSize: 12,), textAlign: TextAlign.center,)
                ],
              );
            }).toList(),
          );
        } 
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(height: height, width: 500,borderRadius: BorderRadius.all(Radius.circular(borderRadio))),
                ),
              ),
            ],
          );
        
      },
    );
  }
}
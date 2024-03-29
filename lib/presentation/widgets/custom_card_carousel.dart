import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:skeletons/skeletons.dart';

class CustomCardCarousel extends ConsumerWidget {


  final double height;
  final double viewportFraction;
  final bool isEnLargeCenterPage;
  final double marginHorizontal;
  final double borderRadio;
  final bool isCircle;
  final Future<List<SongLocalModel>> songRecently;

  const CustomCardCarousel({
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
          return Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(0, 0, 0, 0),
                )
              ],
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 0.6,
                pageSnapping: true,
                height: height,
                enlargeCenterPage: isEnLargeCenterPage,
                viewportFraction: viewportFraction
              ),
              items: snapshot.data!.map((song) {
                return Builder(
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
                          LoardArtwork(id: song.id, width: 800, height: 500, radius: borderRadio),
                          
                          isCircle ?
                          Positioned(
                            bottom: 1,
                            child: Center(child: Text(song.artist, style: const TextStyle(color: Colors.white), overflow: TextOverflow.fade))
                          ) : 
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(song.title, style: const TextStyle(color: Colors.white, ),overflow: TextOverflow.fade),
                                Text(song.artist, style: const TextStyle(color: Colors.white), overflow: TextOverflow.fade),
                              ],
                            )
                          )
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
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
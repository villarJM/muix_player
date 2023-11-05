import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:skeletons/skeletons.dart';

class CustomCardCarouselSquare extends ConsumerWidget {


  final double height;
  final double viewportFraction;
  final bool isEnLargeCenterPage;
  final double marginHorizontal;
  final double borderRadio;
  final bool isCircle;
  final Future<List<SongLocalModel>> songRecently;

  const CustomCardCarouselSquare({
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
                              LoardArtwork(id: song.id, width: 300, height: 110, radius: borderRadio),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.18,
                                left: MediaQuery.of(context).size.width * 0.65,
                                child: Container(
                                  height: 35,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white70),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                    
                                    }, 
                                    child: const Text('Listen Now', style: TextStyle(color: Colors.white),)),
                                ).frosted(
                                  height: 35,
                                  width: 100,
                                  blur: 2.5,
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                ),
                              ), 
                              
                            ],
                          ),
                        );
                      },
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: const Text('Texto'),
                    )
                  ],
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
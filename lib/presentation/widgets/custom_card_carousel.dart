import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomCardCarousel extends StatelessWidget {


  final double height;
  final double viewportFraction;
  final bool isEnLargeCenterPage;
  final double marginHorizontal;
  final double borderRadio;
  final List<SongLocalModel> songRecently;

  const CustomCardCarousel({
    super.key, 
    required this.height,
    required this.viewportFraction, 
    required this.isEnLargeCenterPage,
    required this.marginHorizontal, 
    required this.borderRadio, 
    required this.songRecently
  });


  @override
  Widget build(BuildContext context) {
  final OnAudioQuery audioQuery = OnAudioQuery();
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        enlargeCenterPage: isEnLargeCenterPage,
        viewportFraction: viewportFraction
      ),
      items: songRecently.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                  Color(0XFFFB399A),
                  Color(0XFFAF00FE),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
                  ),
                  borderRadius: BorderRadius.circular(borderRadio)
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                      QueryArtworkWidget(
                        controller: audioQuery, 
                        id: i.id, 
                        type: ArtworkType.AUDIO, 
                        artworkQuality: FilterQuality.high,
                        artworkFit: BoxFit.cover,
                        format: ArtworkFormat.JPEG,
                        artworkBorder: const BorderRadius.all(Radius.circular(10)),
                        artworkHeight: 500,
                        artworkWidth: 500,
                        size: 1800,
                    ),
                    
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
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(i.title, style: const TextStyle(color: Colors.white, ),overflow: TextOverflow.fade),
                          Text(i.artist, style: const TextStyle(color: Colors.white), overflow: TextOverflow.fade),
                        ],
                      )
                    ),
                  ],
                ),
            );
          },
        );
      }).toList(),
    );
  }
}
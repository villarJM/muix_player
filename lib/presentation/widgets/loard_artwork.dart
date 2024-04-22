
import 'package:flutter/material.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LoardArtwork extends StatelessWidget {

  final int id;
  final ArtworkType artworkType;
  final double width;
  final double height;
  final FilterQuality quality;
  final double radius;

  const LoardArtwork({super.key, 
    required this.id,
    this.width = 40,
    this.height = 40,
    this.quality = FilterQuality.low,
    this.radius = 0, 
    required this.artworkType,
  });

  @override
  Widget build(BuildContext context){
    final offlineSongLocal =  getIt<OfflineSongLocal>();
    return FutureBuilder(
      future: offlineSongLocal.getArtwork(id, artworkType),  
      builder: (context, snapshot) {
        final imageUint8List = snapshot.data;
        if (snapshot.hasData && imageUint8List != null) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.black26,
                  offset: Offset(0,0)
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              child: 
              // Image(
              //   image: CacheImageProvider('app://image/$id',imageUint8List),
              //   gaplessPlayback: true,
              //   fit: BoxFit.cover,
              //   width: width,
              //   height: height,
              //   filterQuality: quality,
              // ),
              Image.memory(
                imageUint8List,
                gaplessPlayback: true,
                scale: 1.0,
                fit: BoxFit.cover,
                width: width,
                height: height,
                filterQuality: quality,
            
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },

    );
  
  }
}
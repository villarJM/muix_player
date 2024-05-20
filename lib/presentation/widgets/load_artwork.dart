
import 'package:flutter/material.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LoadArtwork extends StatelessWidget {

  final int id;
  final ArtworkType artworkType;
  final double width;
  final double height;
  final int size;
  final FilterQuality quality;
  final double radius;
  final ImageFrameBuilder? frameBuilder;

  const LoadArtwork({super.key, 
    required this.id,
    this.width = 50,
    this.height = 50,
    this.size = 200,
    this.quality = FilterQuality.low,
    this.radius = 0, 
    required this.artworkType,
    this.frameBuilder
  });

  @override
  Widget build(BuildContext context){
    final offlineSongLocal =  getIt<OfflineSongLocal>();
    return FutureBuilder(
      future: offlineSongLocal.getArtwork(id, artworkType, size, 100),  
      builder: (context, imageUint8List) {
        if (imageUint8List.hasData && imageUint8List.data != null) {
          return SizedBox(
            height: height,
            width: width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: CachedMemoryImage(
                uniqueKey: 'app://image/$id',
                bytes: imageUint8List.data,
                width: width,
                height: height,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                filterQuality: quality,
                frameBuilder: frameBuilder,
              ),
              // Image(
              //   image: CacheImageProvider('app://image/$id',imageUint8List.data!),
              //   gaplessPlayback: true,
              //   fit: BoxFit.cover,
              //   width: width,
              //   height: height,
              //   filterQuality: quality,
              // ),
              // Image.memory(
              //   imageUint8List.data!,
              //   gaplessPlayback: true,
              //   scale: 1.0,
              //   fit: BoxFit.cover,
              //   width: width,
              //   height: height,
              //   filterQuality: quality,
            
              // ),
            ),
          );
        }
        return Image.asset(
          'assets/images/placeholder_song.png',
          height: height,
          width: width,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
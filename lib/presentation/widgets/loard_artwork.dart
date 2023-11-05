import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/presentation/widgets/cache_imagen_provider.dart';
import 'package:muix_player/provider/song_local_provider.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:transparent_image/transparent_image.dart';

class LoardArtwork extends ConsumerWidget {

  final int id;
  final double width;
  final double height;
  final FilterQuality quality;
  final double radius;

  const LoardArtwork({
    super.key, 
    required this.id,
    this.width = 40,
    this.height = 40,
    this.quality = FilterQuality.low,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return FutureBuilder(
      future: ref.watch(songLocalRepositoryProvider).getImage(id), 
      builder: (context, snapshot) {
        final imageUint8List = snapshot.data;
        if (snapshot.hasData && imageUint8List != null) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            child: 
            Image(
              image: CacheImageProvider('app://image/$id',imageUint8List),
              gaplessPlayback: true,
              fit: BoxFit.cover,
              width: width,
              height: height,
              filterQuality: quality,
            ),
            // Image.memory(
            //   imageUint8List,
            //   gaplessPlayback: true,
            //   scale: 1.0,
            //   fit: BoxFit.cover,
            //   width: width,
            //   height: height,
            //   filterQuality: quality,
          
            // ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },

    );
  
  }
}
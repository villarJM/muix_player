import 'package:flutter/material.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Artist extends StatefulWidget {
  const Artist({ Key? key }) : super(key: key);

  @override
  ArtistState createState() => ArtistState();
}

class ArtistState extends State<Artist> {
  List<AlbumModel> artistsLoad = [];

  @override
  void initState() {
    loadArtists();
    super.initState();
  }

   Future<List<AlbumModel>> loadArtists() async {
    artistsLoad = await OfflineSongLocal().getAlbums();
    setState(() {});
    return artistsLoad;
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 7,
          childAspectRatio: 0.6,
        ),
        itemCount: artistsLoad.length,
        itemBuilder: (context, index) {
        
        final artist = artistsLoad[index];

        BorderRadius? borderRadius;
        TextAlign? textAlign;
        if (index % 6 == 0 || index == 0) {
          borderRadius = const BorderRadius.only(
            bottomLeft: Radius.circular(100.0),
          );
          textAlign = TextAlign.end;
        } else if (index % 3 == 0) {
          borderRadius = const BorderRadius.only(
            topLeft: Radius.circular(100.0),
          );
        }

        if (index % 6 == 1) {
          borderRadius = const BorderRadius.only(
            bottomRight: Radius.circular(100.0),
            topLeft: Radius.circular(100.0),
          );
        } else if (index % 2 == 0 && index % 6 != 0) {
          borderRadius = const BorderRadius.only(
            topRight: Radius.circular(100.0),
            bottomLeft: Radius.circular(100.0),
          );
          textAlign = TextAlign.end;
        }

        if (index % 6 == 2) {
          borderRadius = const BorderRadius.only(
            topRight: Radius.circular(100.0),
          );
          textAlign = TextAlign.center;
        } else if (index % 6 == 5) {
          borderRadius = const BorderRadius.only(
            bottomRight: Radius.circular(100.0),
          );
        }
        if (index % 1 == 2) {
          // Tercer elemento de la segunda fila
          borderRadius = const BorderRadius.only(
            bottomLeft: Radius.circular(100.0),
            topRight: Radius.circular(100.0),
          );
        } 
        return GridTile(
          child: 
          Stack(
          alignment: Alignment.topCenter,
          children: [
            QueryArtworkWidget(
              id: artist.id,
              type: ArtworkType.ALBUM,
              artworkBorder: borderRadius,
              artworkQuality: FilterQuality.high,
              artworkFit: BoxFit.cover,
              quality: 100,
              artworkWidth: 150,
              artworkHeight: 150,
              size: 1000,
            ),
            Container(
              height: 240,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, AppMuixTheme.background.withOpacity(0.6), AppMuixTheme.background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                borderRadius: borderRadius,
              ),
            ),   
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2
                ),
                gradient: LinearGradient(
                  colors: [Colors.transparent, AppMuixTheme.background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                borderRadius: borderRadius,
              ),
            ),
            
            Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(artist.album, maxLines: 1, overflow: TextOverflow.clip, style: AppMuixTheme.textUrbanistMediumPrimary12, textAlign: textAlign,), ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),       
        );
    },
        // children: artistsLoad.map((e) => Stack(
        //   alignment: Alignment.topCenter,
        //   children: [
        //     QueryArtworkWidget(
        //       id: e.id,
        //       type: ArtworkType.ALBUM,
        //       artworkBorder: BorderRadius.circular(10),
        //       artworkQuality: FilterQuality.high,
        //       artworkFit: BoxFit.cover,
        //       quality: 100,
        //       artworkWidth: 200,
        //       artworkHeight: 200,
        //       size: 1000,
        //     ),
        //     Container(
        //       height: 200,
        //       decoration: BoxDecoration(
        //         gradient: LinearGradient(
        //           colors: [Colors.transparent, AppMuixTheme.background],
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter
        //         ),
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),   
        //     Container(
        //       decoration: BoxDecoration(
        //         border: Border.all(
        //           color: Colors.white,
        //           width: 2
        //         ),
        //         gradient: LinearGradient(
        //           colors: [Colors.transparent, AppMuixTheme.background],
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter
        //         ),
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),
            
        //     Positioned(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //         child: Align(
        //           alignment: Alignment.bottomCenter,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               Row(
        //                 children: [
        //                   Expanded(child: Text(e.artist, maxLines: 1, overflow: TextOverflow.clip, style: AppMuixTheme.textUrbanistMediumPrimary12,),),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       )
        //     ),
        //   ],
        // ),       
        // ).toList(),
      ),
    );
  }
}
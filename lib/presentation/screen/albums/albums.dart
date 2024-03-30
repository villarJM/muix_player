import 'package:flutter/material.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Albums extends StatefulWidget {
const Albums({ Key? key }) : super(key: key);

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {

  List<AlbumModel> albumsLoad = [];

  @override
  void initState() {
    loadAlbums();
    super.initState();
  }

   Future<List<AlbumModel>> loadAlbums() async {
    albumsLoad = await OfflineSongLocal().getAlbums();
    setState(() {});
    return albumsLoad;
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 7,
        shrinkWrap: true,
        childAspectRatio: 0.8,
        children: albumsLoad.map((e) => Stack(
          alignment: Alignment.topCenter,
          children: [
            QueryArtworkWidget(
              id: e.id,
              type: ArtworkType.ALBUM,
              artworkBorder: BorderRadius.circular(10),
              artworkQuality: FilterQuality.high,
              artworkFit: BoxFit.cover,
              quality: 100,
              artworkWidth: 200,
              artworkHeight: 200,
              size: 1000,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, AppMuixTheme.background],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                borderRadius: BorderRadius.circular(10),
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
                borderRadius: BorderRadius.circular(10),
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
                      Text(e.album, maxLines: 1, overflow: TextOverflow.fade, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                      Row(
                        children: [
                          Expanded(child: Text(e.artist ?? "", maxLines: 1, overflow: TextOverflow.clip, style: AppMuixTheme.textUrbanistMediumPrimary12,),),
                          Text(' | 2023', maxLines: 1, overflow: TextOverflow.fade, textAlign: TextAlign.end, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                        ],
                      ),
                      Text('${e.numOfSongs} Songs', style: AppMuixTheme.textUrbanistMediumPrimary12,)
                    ],
                  ),
                ),
              )
            ),
          ],
        ),       
        ).toList(),
      ),
    );
  }
}
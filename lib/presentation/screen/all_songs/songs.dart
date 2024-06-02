import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/providers/color_state.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/provider/color_adaptable.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';


class Songs extends StatefulWidget {
const Songs({ Key? key }) : super(key: key);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> with AutomaticKeepAliveClientMixin {

  final dominateColor = DominateColor();
  ScrollController scrollController = ScrollController();
  

  @override
  Widget build(BuildContext context){
    final colorAdaptable = Provider.of<ColorAdaptable>(context);
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
      child: ValueListenableBuilder<List<SongModel>>(
        valueListenable: audioManager.songListNotifier,
        builder: (context, playlistSongs,_) {
          return Scrollbar(
            thickness: 20,
            controller: scrollController,
            thumbVisibility: true,
            interactive: true,
            child: ListView.builder(
              itemExtent: 45.h,
              semanticChildCount: playlistSongs.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: playlistSongs.length,
              addAutomaticKeepAlives: true,
              controller: scrollController,
              itemBuilder: (context, index) {
                final songs = playlistSongs[index];
                return ValueListenableBuilder<bool>(
                  valueListenable: audioManager.isShuffleModeEnabledNotifier,
                  builder: (context, isEnabled, child) {
                    return ListItem(
                      key: Key(songs.id.toString()),
                      height: 45.h,
                      title: Text(songs.title, maxLines: 1, style: AppMuixTheme.textTitleUrbanistRegular16,),
                      subtitle: Text(songs.artist ?? "", maxLines: 1, style: AppMuixTheme.textUrbanistBold16,),
                      artwork: null,
                      // LoadArtwork(
                      //   key: Key(songs.id.toString()),
                      //   id: songs.id, 
                      //   artworkType: ArtworkType.AUDIO,
                      //   height: 100.h,
                      //   quality: FilterQuality.high,
                      //   size: 1600,
                      // ),
                      onTap: () {
                        colorAdaptable.getDominantingColorImage(songs.id, ArtworkType.AUDIO, 200, 50);
                        if (isEnabled) {
                          audioManager.shuffle();
                        }
                        audioManager..skipToNextQueueItem(index)..play();
                      },
                      icon: popupMenuButtonSongs(context, songs.id),
                      borderRadius: BorderRadius.circular(10.0),
                    );
                  }
                );
                
              },
            ),
          );
        }
      ) 
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
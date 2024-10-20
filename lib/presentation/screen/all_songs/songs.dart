import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/provider/color_adaptable.dart';
import 'package:muix_player/theme/muix_theme.dart';
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
    final muixTheme = context.read<MuixTheme>();
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListItem(
                        key: Key(songs.id.toString()),
                        title: Text(songs.title, maxLines: 1, style: muixTheme.styleUrbanist16WhiteW500,),
                        subtitle: Text(songs.artist ?? "", maxLines: 1, style: muixTheme.styleUrbanist16WhiteW700,),
                        artwork:LoadArtwork(
                          key: Key(songs.id.toString()),
                          id: songs.id, 
                          artworkType: ArtworkType.AUDIO,
                          height: 55,
                          quality: FilterQuality.high,
                          size: 1600,
                        ),
                        borderRadiusArtwork: const BorderRadiusDirectional.horizontal(start: Radius.circular(10)),
                        onTap: () async {
                           await colorAdaptable.getDominantingColorImage(songs.id, ArtworkType.AUDIO, 200, 50);
                          if (isEnabled) {
                            audioManager.shuffle();
                          }
                          audioManager..skipToNextQueueItem(index)..play();
                        },
                        icon: popupMenuButtonSongs(context, songs.id),
                        borderRadius: BorderRadius.circular(10),
                      ),
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
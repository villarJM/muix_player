import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/providers/color_state.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';


class Songs extends ConsumerStatefulWidget {
const Songs({ Key? key }) : super(key: key);

  @override
  ConsumerState<Songs> createState() => _SongsState();
}

class _SongsState extends ConsumerState<Songs> with AutomaticKeepAliveClientMixin {

  final dominateColor = DominateColor();
  

  @override
  Widget build(BuildContext context){
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ValueListenableBuilder<List<MediaItem>>(
        valueListenable: audioManager.playlistNotifier,
        builder: (context, playlistSongs,_) {
          return ListView.builder(
            primary: true,
            scrollDirection: Axis.vertical,
            itemCount: playlistSongs.length,
            addAutomaticKeepAlives: true,
            itemBuilder: (context, index) {
              final songs = playlistSongs[index];
              return ListItem(
                height: 45.h,
                title: Text(songs.title, maxLines: 1, style: AppMuixTheme.textTitleUrbanistRegular16,),
                subtitle: Text(songs.artist ?? "", maxLines: 1, style: AppMuixTheme.textUrbanistBold16,),
                artwork: LoadArtwork(
                  id: int.parse(songs.id), 
                  artworkType: ArtworkType.AUDIO,
                  height: 100.h,
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                ),
                onTap: () {
                  ref.watch(colorStateProvider.notifier).getDominantingColorImage(int.parse(songs.id), ArtworkType.AUDIO, 200);
                  audioManager..skipToNextQueueItem(index)..play();
                },
                icon: popupMenuButtonSongs(context, int.parse(songs.id)),
                borderRadius: BorderRadius.circular(10.0),
              );
              
            },
          );
        }
      ) 
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
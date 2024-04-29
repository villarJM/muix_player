import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/config/menu/popup_menu_items_songs.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/presentation/providers/color_state.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/widgets/list_item.dart';
import 'package:muix_player/presentation/widgets/load_artwork.dart';
import 'package:muix_player/presentation/widgets/modal_playlist.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:muix_player/util/sample_item.dart';
import 'package:on_audio_query/on_audio_query.dart';


class Songs extends ConsumerStatefulWidget {
const Songs({ Key? key }) : super(key: key);

  @override
  ConsumerState<Songs> createState() => _SongsState();
}

class _SongsState extends ConsumerState<Songs> with AutomaticKeepAliveClientMixin {

  SampleItem? selectedItem;
  final audioManager = getIt<AudioManager>();
  final offlineSongLocal = getIt<OfflineSongLocal>();
  final dominateColor = DominateColor();
  final textController = TextEditingController();
  int? valueRadio;
  var playlistId = 0;
  var audioId = 0;
  bool isNewPlaylist = true;

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
                icon: popupMenuButton(context, int.parse(songs.id)),
                borderRadius: BorderRadius.circular(10.0),
              );
              
            },
          );
        }
      ) 
    );
  }

  PopupMenuButton<SampleItem> popupMenuButton(BuildContext context, int songId) {
    return PopupMenuButton<SampleItem>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(0),
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0)
      )
    ),
      initialValue: selectedItem,
      onSelected: (SampleItem item) {
        switch (item) {
          case SampleItem.itemOne:
            modalPlaylist(
              context: context, 
              controller: textController,
              isNew: isNewPlaylist,
              valueListenable: audioManager.playlistListNotifier,
              offlineSongLocal: offlineSongLocal,
              audioManager: audioManager,
              playlistId: playlistId,
              audioId: audioId,
              songId: songId,
              valueRadio: valueRadio,
            );
            break;
          case SampleItem.itemTwo:
            debugPrintStack(label: 'Delete');
            break;
          default:
        }
      },
      itemBuilder: (context) => popupItems
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
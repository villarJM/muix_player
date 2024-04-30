import 'package:flutter/material.dart';
import 'package:muix_player/config/menu/popup_menu_items_songs.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/presentation/widgets/modal_playlist.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:muix_player/util/sample_item.dart';

SampleItem? selectedItem;
final textController = TextEditingController();
final audioManager = getIt<AudioManager>();
final offlineSongLocal = getIt<OfflineSongLocal>();
int? valueRadio;
var playlistId = 0;
var audioId = 0;
bool isNewPlaylist = true;

PopupMenuButton<SampleItem> popupMenuButtonSongs(BuildContext context, int songId) {
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
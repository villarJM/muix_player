import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/util/sample_item.dart';

const popupItems = <PopupMenuEntry<SampleItem>>[
  PopupMenuItem(
    value: SampleItem.itemOne,
    child: Row(
      children: [
        Iconify(Ic.round_playlist_add),
        Text('Add To Playlist'),
      ],
    ),
  ),
  PopupMenuItem(
    value: SampleItem.itemTwo,
    child: Row(
      children: [
        Iconify(Mdi.delete_outline),
        Text('Delete')
      ],
    ),
  )
];

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:muix_player/domain/entities/song_local.dart';
// final songLocalProvider = StateProvider<SongLocal>((ref) => const SongLocal(
//   id: 0, 
//   title: '', 
//   artist: '', 
//   album: '', 
//   genre: '', 
//   duration: 0, 
//   data: '',
//   artwork: ,
// ));

// void changeItem(StateController<SongLocal> itemController, int id, String title, String artist, String album, String gender, int duration, String data) {
//   final currentItem = itemController.state;
//   final updatedItem = currentItem.copyWith(
//     id: id, 
//     title: title, 
//     artist: artist, 
//     album: album, 
//     genre: gender, 
//     duration: duration, 
//     data: data
//   );
//   itemController.state = updatedItem; // Notifica a Riverpod sobre el cambio
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/helper/offline_song_local.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future modalPlaylist<T>({
    required BuildContext context,
    required TextEditingController? controller,
    required bool isNew,
    required ValueListenable<List<PlaylistModel>> valueListenable,
    required OfflineSongLocal offlineSongLocal,
    required AudioManager audioManager,
    required int playlistId,
    required int audioId,
    required int? valueRadio,
    required int songId,

  }) {
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => Dialog(
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: GlassContainer(
            height: 360.h,
            width: double.infinity,
            blur: 10,
            gradient: LinearGradient(
              colors: [AppMuixTheme.background.withOpacity(0.40), AppMuixTheme.background.withOpacity(0.10)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderGradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.39, 0.40, 1.0],
            ),
            borderWidth: 1.2,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 360.h,
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Playlist', style: AppMuixTheme.textUrbanistSemiBoldPrimary20,),
                  const Divider(color: Colors.white,),
                  Offstage(
                    offstage: isNew,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          hintText: 'New Playlist',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: Colors.white
                            ),
                          ),
                          fillColor: AppMuixTheme.backgroundSecondary,
                          filled: true,
                        ),
                        controller: controller,
                      ),
                    ),
                  ),
                  Flexible(
                    child:  ValueListenableBuilder<List<PlaylistModel>>(
                      valueListenable: valueListenable,
                      builder: (_, playlist, __) {
                        return ListView.builder(
                          itemCount: playlist.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${playlist[index].playlist}  -  ${playlist[index].numOfSongs} Songs'),
                                Radio(
                                  value: index, 
                                  groupValue: valueRadio, 
                                  onChanged: (value) {
                                    valueRadio = value!;
                                    playlistId = playlist[index].id;
                                    audioId = songId;
                                    setState(() {
                                      
                                    });
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }
                    )
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => isNew = !isNew),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppMuixTheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            )
                          ), 
                          child: Text(isNew ? 'New Playlist' : 'Cancel'),
                        )
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            isNew ? 
                            offlineSongLocal.addToPlaylist(playlistId, audioId) :
                            offlineSongLocal.createPlayList(controller!.text);
    
                            audioManager.loadPlaylists();
                            valueRadio = null;
    
                            isNew ? Navigator.of(context).pop() : null;
    
                            isNew = !isNew;
                            setState(() {
    
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppMuixTheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            )
                          ),  
                          child: Text(isNew ? 'Add' : 'Save'),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
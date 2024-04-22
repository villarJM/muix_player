import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/presentation/providers/color_state.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/widgets/list_item.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../services/service_locator.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class Songs extends ConsumerStatefulWidget {
const Songs({ Key? key }) : super(key: key);

  @override
  ConsumerState<Songs> createState() => _SongsState();
}

class _SongsState extends ConsumerState<Songs> {

  SampleItem? selectedItem;
  ScrollController scrollController = ScrollController();
  final audioManager = getIt<AudioManager>();
  final dominateColor = DominateColor();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ValueListenableBuilder<List<MediaItem>>(
        valueListenable: audioManager.playlistNotifier,
        builder: (context, playlistSongs,_) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return ListView.builder(
                primary: true,
                scrollDirection: Axis.vertical,
                itemCount: playlistSongs.length,
                itemBuilder: (context, index) {
                  final songs = playlistSongs[index];
                  return ListItem(
                    height: orientation == Orientation.portrait ? 45.h : 50.h,
                    title: Text(songs.title, maxLines: 1, style: AppMuixTheme.textTitleUrbanistRegular16,),
                    subtitle: Text(songs.artist ?? "", maxLines: 1, style: AppMuixTheme.textUrbanistBold16,),
                    artwork: QueryArtworkWidget(
                      id: int.parse(songs.id),
                      type: ArtworkType.AUDIO,
                      keepOldArtwork: true,
                      artworkBorder: BorderRadius.circular(0),
                      artworkFit: BoxFit.cover,
                      artworkHeight: 100.h,
                      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) return child;
                        return AnimatedOpacity(
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOut,
                          child: child,
                        );
                      },
                      nullArtworkWidget: Image.asset(
                        'assets/images/placeholder_song.png'
                      ),
                    ),
                    onTap: () {
                      ref.watch(colorStateProvider.notifier).getDominantingColorImage(int.parse(songs.id), ArtworkType.AUDIO);
                      audioManager..skipToNextQueueItem(index)..play();
                    },
                    icon: PopupMenuButton<SampleItem>(
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
                          setState(() {
                            selectedItem = item;
                          });
                        },
                        itemBuilder: (context) => <PopupMenuEntry<SampleItem>>[
                          PopupMenuItem(
                            value: SampleItem.itemOne,
                            child: Row(
                              children: [
                                const Iconify(Ic.round_playlist_add),
                                TextButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
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
                                                Padding(
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
                                                  ),
                                                ),
                                                Flexible(
                                                  child:  ValueListenableBuilder<List<PlaylistModel>>(
                                                    valueListenable: audioManager.playlistListNotifier,
                                                    builder: (_, playlist, __) {
                                                      return ListView.builder(
                                                        itemCount: playlist.length,
                                                        itemBuilder: (context, index) {
                                                          return Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('${playlist[index].playlist}  -  ${playlist[index].numOfSongs} Songs'),
                                                              Radio(
                                                                value: 0, 
                                                                groupValue: 1, 
                                                                onChanged: (value) {},
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
                                                        onPressed: (){}, 
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: AppMuixTheme.primary,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.0)
                                                          )
                                                        ), 
                                                        child: const Text('New Playlist'),
                                                      )
                                                    ),
                                                    const SizedBox(width: 10,),
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: (){}, 
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: AppMuixTheme.primary,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.0)
                                                          )
                                                        ),  
                                                        child: const Text('Save'),
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
                                  child: const Text('Add To Playlist'),

                                )
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: SampleItem.itemTwo,
                            child: Row(
                              children: [
                                Iconify(Mdi.delete_outline),
                                Text('Delete')
                              ],
                            ),
                          )
                        ]
                      ), 
                      
                    boxDecoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: index % 2 == 0 ? const Radius.circular(20) : Radius.zero,
                        topRight: index % 2 == 0 ? Radius.zero : const Radius.circular(20),
                        bottomLeft: index % 2 == 0 ? Radius.zero : const Radius.circular(20),
                        bottomRight: index % 2 == 0 ? const Radius.circular(20) : Radius.zero,
                      ),
                      gradient: const LinearGradient(
                        colors: [Color.fromARGB(255, 5, 23, 39), Color.fromARGB(200, 228, 211, 182),Color.fromARGB(255, 228, 211, 182),],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    ),
                    imageBorderRadius: BorderRadius.only(
                      topLeft: index % 2 == 0 ? const Radius.circular(19) : Radius.zero,
                      topRight: index % 2 == 0 ? Radius.zero : const Radius.circular(19),
                      bottomLeft: index % 2 == 0 ? Radius.zero : const Radius.circular(19),
                      bottomRight: index % 2 == 0 ? const Radius.circular(19) : Radius.zero,
                    ),
                  );
                  
                },
              );
            }
          );
        }
      ) 
    );
  }
}
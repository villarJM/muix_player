import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/config/menu/popup_menu_items_playlist.dart';
import 'package:muix_player/helper/helpers.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/presentation/screen/playlist/playlists.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:muix_player/util/util.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatefulWidget {
  final TabController tabController;
  const PlaylistScreen({ Key? key, required this.tabController }) : super(key: key);

  @override
  PlaylistScreenState createState() => PlaylistScreenState();
}

class PlaylistScreenState extends State<PlaylistScreen> {

  final offlineSongLocal = getIt<OfflineSongLocal>();
  final audioManager = getIt<AudioManager>();
  SampleItem? selectedItem;

  final textCUController = TextEditingController();
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }
  
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ValueListenableBuilder<List<PlaylistModel>>(
        valueListenable: audioManager.playlistListNotifier,
        builder: ( context, playlist, __) {
          return Column(
            children: [
              IconButton(
                onPressed: () => modalInput(
                context: context, 
                controller: textCUController,
                onPressed: () {
                  offlineSongLocal.createPlayList(textCUController.text);
                  textCUController.clear();
                  audioManager.loadPlaylists();
                  Navigator.of(context).pop();
                },
              ), 
              icon: const Iconify(Ic.round_playlist_add),
              ),
              Flexible(
                child: GridView.builder(
                  itemCount: playlist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 7,
                    childAspectRatio: 0.8,
                  ),
                  controller: scrollController,
                  itemBuilder: (context, index) => ValueListenableBuilder<List<SongModel>>(
                    valueListenable: audioManager.playlistCustomNotifier,
                    builder: ( context, songList, __) {
                      return InkWell(
                        onTap: () async {
                          
                          await audioManager.loadPlaylist(AudiosFromType.PLAYLIST, playlist[index].playlist);
                          // ignore: use_build_context_synchronously
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistDetailScreen(songList: audioManager.playlistCustomNotifier.value),));
                        },
                        child: Stack(
                          children: [
                            GlassContainer(
                              height: 260.h,
                              width: double.infinity,
                              blur: 5,
                              gradient: LinearGradient(
                                colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
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
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  LoadArtwork(
                                    id: playlist[index].id,
                                    artworkType: ArtworkType.PLAYLIST,
                                    quality: FilterQuality.high,
                                    width: double.infinity,
                                    height: 120.h,
                                    size: 1800,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Align(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text('${playlist[index].playlist}: ${playlist[index].numOfSongs} Songs', style: AppMuixTheme.textUrbanistMediumPrimary12,)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            popupMenuButton(playlist[index]),
                          ],
                        ),
                      );
                    }
                  ),       
                ),
              ),
              SizedBox(height: 60.h,),
            ],
          );
        }
      ),
    );
  }

  Positioned popupMenuButton(PlaylistModel playlist) {
    return Positioned(
      child: PopupMenuButton<SampleItem>(
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
              modalInput(
                context: context, 
                controller: textCUController,
                onPressed: () {
                  offlineSongLocal.createPlayList(textCUController.text);
                  textCUController.clear();
                  audioManager.loadPlaylists();
                  Navigator.of(context).pop();
                },
              );
              break;
            case SampleItem.itemTwo:
              setState(() => textCUController.text = playlist.playlist);
              modalInput(
                context: context,
                controller: textCUController,
                onPressed: () {
                  offlineSongLocal.renamePlayList( playlist.id, textCUController.text);
                  textCUController.clear();
                  audioManager.loadPlaylists();
                  Navigator.of(context).pop();
                },
              );
              break;
            case SampleItem.itemThree:
              modalDelete(
                context: context,
                onPressed: () {
                  offlineSongLocal.deletePlayList(playlist.id);
                  audioManager.loadPlaylists();
                  Navigator.of(context).pop();
                },
              );
              break;
            default:
          }
        },
        itemBuilder: (context) => popupItems
      ), 
    );
  }
}
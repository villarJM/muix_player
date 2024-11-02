import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  final TabController controller;
const Dashboard({ Key? key, required this.controller }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>  with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context){
    final muixTheme = context.read<MuixTheme>();
    final audioManager = getIt<AudioManager>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [

          const SizedBox(height: 20,),
          carouselRecentlySongs(audioManager, muixTheme),
          
          const SizedBox(height: 20,),
          carouselNewAlbums(audioManager, muixTheme),

          const SizedBox(height: 5,),
          carouselPlaylist(audioManager, widget.controller, muixTheme),
          SizedBox(height: 140.h,),
        ],
      ),
    );
  }

  ValueListenableBuilder<List<PlaylistModel>> carouselPlaylist(AudioManager audioManager, TabController tabController, MuixTheme muixTheme) {
    return ValueListenableBuilder<List<PlaylistModel>>(
      valueListenable: audioManager.playlistListNotifier,
      builder: (_, playlistSong, __) {
        return CustomCarouselItem(
          labelLeft: Text('Playlist', textAlign: TextAlign.center, style: muixTheme.styleUrbanist11WhiteW600),
          labelRight: Text('View All', textAlign: TextAlign.center, style: muixTheme.styleUrbanist11WhiteW600),
          enableIndicator: true,
          indicatorOnTap: () => tabController.animateTo(5),
          borderRadiusGeometry: BorderRadius.circular(25),
          borderRadiusIndicatorL: BorderRadius.circular(8),
          borderRadiusIndicatorR: BorderRadius.circular(8),
          viewportFraction: 0.5,
          listItem: playlistSong,
        );
      }
    );
  }

  ValueListenableBuilder<List<SongModel>> carouselNewAlbums(AudioManager audioManager, MuixTheme muixTheme) {
    return ValueListenableBuilder<List<SongModel>>(
          valueListenable: audioManager.recentlyListNotifier,
          builder: (_, recentlySong, __) {
            return CustomCarouselItem(
              labelLeft:  Text('New Albums', textAlign: TextAlign.center, style: muixTheme.styleUrbanist11WhiteW600,),
              labelRight: Text('View All', textAlign: TextAlign.center, style: muixTheme.styleUrbanist11WhiteW600, ),
              enableIndicator: true,
              borderRadiusGeometry: BorderRadius.circular(25),
              borderRadiusIndicatorL: BorderRadius.circular(8),
              borderRadiusIndicatorR: BorderRadius.circular(8),
              viewportFraction: 0.5,
              listItem: recentlySong,
            );
          }
        );
  }

  ValueListenableBuilder<List<SongModel>> carouselRecentlySongs(AudioManager audioManager, MuixTheme muixTheme) {
    return ValueListenableBuilder<List<SongModel>>(
          valueListenable: audioManager.recentlyListNotifier,
          builder: (_, recentlySong, __) {
            return CustomCarouselItem(
              borderRadiusGeometry: BorderRadius.circular(40),
              viewportFraction: 1.0,
              listItem: recentlySong,
            );
          }
        );
  }
}
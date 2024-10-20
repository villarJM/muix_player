import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Dashboard extends StatefulWidget {
  final TabController controller;
const Dashboard({ Key? key, required this.controller }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>  with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context){

    final audioManager = getIt<AudioManager>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [

          const SizedBox(height: 20,),
          carouselRecentlySongs(audioManager),
          
          const SizedBox(height: 20,),
          carouselNewAlbums(audioManager),

          const SizedBox(height: 5,),
          carouselPlaylist(audioManager, widget.controller),
          SizedBox(height: 140.h,),
        ],
      ),
    );
  }

  ValueListenableBuilder<List<PlaylistModel>> carouselPlaylist(AudioManager audioManager, TabController tabController) {
    return ValueListenableBuilder<List<PlaylistModel>>(
      valueListenable: audioManager.playlistListNotifier,
      builder: (_, playlistSong, __) {
        return CustomCarouselItem(
          labelL: Text('Playlist', textAlign: TextAlign.center, style: AppMuixTheme.textUrbanistMediumPrimary12),
          labelR: Text('View All', textAlign: TextAlign.center, style: AppMuixTheme.textUrbanistMediumPrimary12),
          enableIndicator: true,
          indicatorOnTap: () => tabController.animateTo(5),
          borderRadiusGeometry: BorderRadius.circular(20),
          alignmentL: Alignment.centerLeft,
          alignmentR: Alignment.centerRight,
          borderRadiusGeometryIndicatorL: const BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0) 
          ),
          borderRadiusGeometryIndicatorR: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0) 
          ),
          viewportFraction: 0.5,
          listItem: playlistSong,
        );
      }
    );
  }

  ValueListenableBuilder<List<SongModel>> carouselNewAlbums(AudioManager audioManager) {
    return ValueListenableBuilder<List<SongModel>>(
          valueListenable: audioManager.recentlyListNotifier,
          builder: (_, recentlySong, __) {
            return CustomCarouselItem(
              labelL:  Text('New Albums', textAlign: TextAlign.center, style:AppMuixTheme.textUrbanistMediumPrimary12),
              labelR: Text('View All', textAlign: TextAlign.center, style: AppMuixTheme.textUrbanistMediumPrimary12),
              enableIndicator: true,
              borderRadiusGeometry: BorderRadius.circular(20),
              alignmentL: Alignment.centerLeft,
              alignmentR: Alignment.centerRight,
              borderRadiusGeometryIndicatorL: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0) 
              ),
              borderRadiusGeometryIndicatorR: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0) 
              ),
              viewportFraction: 0.5,
              listItem: recentlySong,
            );
          }
        );
  }

  ValueListenableBuilder<List<SongModel>> carouselRecentlySongs(AudioManager audioManager) {
    return ValueListenableBuilder<List<SongModel>>(
          valueListenable: audioManager.recentlyListNotifier,
          builder: (_, recentlySong, __) {
            return CustomCarouselItem(
              borderRadiusGeometry: BorderRadius.circular(20),
              alignmentL: Alignment.topLeft,
              alignmentR: Alignment.topRight,
              viewportFraction: 1.0,
              listItem: recentlySong,
            );
          }
        );
  }
}
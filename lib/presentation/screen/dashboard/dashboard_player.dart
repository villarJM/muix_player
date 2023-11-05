import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/presentation/screen/widgets/gradient_background.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:muix_player/presentation/widgets/custom_card_carousel.dart';
import 'package:muix_player/presentation/widgets/custom_card_carousel_circle.dart';
import 'package:muix_player/presentation/widgets/custom_card_carousel_square.dart';
import 'package:muix_player/provider/song_local_provider.dart';

class DashboardPlayer extends ConsumerStatefulWidget {

  static const String name = '/';

  const DashboardPlayer({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardPlayer> createState() => _DashboardPlayerState();
}

class _DashboardPlayerState extends ConsumerState<DashboardPlayer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Muix Player'),
        backgroundColor: const Color(0XFFedf5f8),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          const GradientBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                // Title Carousel
                const _TitleCarousel(left: 10, top: 10, title: 'New Single',),
                // Carousel Card New Single Music
                const SizedBox(height: 10,),
                CustomCardCarousel(height: 200.0, viewportFraction: 1.0, isEnLargeCenterPage: true, marginHorizontal: 10.0, borderRadio: 10.0, isCircle: false, songRecently: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal()),
        
                const SizedBox(height: 20,),
                // Title Carousel
                const _TitleCarousel(left: 10, top: 0, title: 'Most Played',),
                // Carousel Card Most Played
                const SizedBox(height: 10,),
                CustomCardCarouselSquare(height: 130.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 5.0, borderRadio: 10.0,isCircle: false, songRecently: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal()),
        
                const SizedBox(height: 10,),
                // Title Carousel
                const _TitleCarousel(left: 10, top: 0, title: 'Playlist',),
                // Carousel Card Playlist
                const SizedBox(height: 10,),
                CustomCardCarouselSquare(height: 130.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 5.0, borderRadio: 10.0,isCircle: false, songRecently: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal()),
        
                const SizedBox(height: 10,),
                // Title Carousel
                const _TitleCarousel(left: 10, top: 0, title: 'Artist',),
                // Carousel Card Playlist
                const SizedBox(height: 10,),
                CustomCardCarouselCircle(height: 130.0, viewportFraction: 0.225, isEnLargeCenterPage: false, marginHorizontal: 13.0, borderRadio: 60.0,isCircle: true, songRecently: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal(),)
              ],
            ),
          ),
        ],
        
      ),
      drawer: SideMenu(scaffoldKey: scaffoldKey,),
    );
  }
}

class _TitleCarousel extends StatefulWidget {

  final double left;
  final double top;
  final String title;

  const _TitleCarousel({ 
    required this.left, 
    required this.top, 
    required this.title,
  });

  @override
  State<_TitleCarousel> createState() => _TitleCarouselState();
}

class _TitleCarouselState extends State<_TitleCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.fromLTRB(widget.left, widget.top, 0, 0),
          child: Text(
            widget.title,
            textAlign: TextAlign.left,
          )),
    );
  }
}

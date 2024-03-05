import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muix_player/domain/usecases/audio_context_manager.dart';
import 'package:muix_player/presentation/providers/interactive_color_state_provider.dart';
import 'package:muix_player/presentation/providers/song_info_state_provider.dart';
import 'package:muix_player/presentation/widgets/custom_card_carousel.dart';
import 'package:muix_player/presentation/widgets/custom_card_carousel_circle.dart';
import 'package:muix_player/presentation/widgets/custom_card_carousel_square.dart';
import 'package:muix_player/presentation/widgets/custom_selected_song_box.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
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
    return Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    // Carousel Card New Single Music
                    const SizedBox(height: 20,),
                    CustomCardCarousel(height: 200.0, viewportFraction: 1.0, isEnLargeCenterPage: true, marginHorizontal: 20.0, borderRadio: 10.0, isCircle: false, songRecently: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal()),
        
                    const SizedBox(height: 20,),
                    // Title Carousel
                    const _TitleCarousel(left: 20, top: 0, title: 'New Albums',),
                    // Carousel Card Most Played
                    const SizedBox(height: 20,),
                    CustomCardCarouselSquare(height: 150.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 15.0, borderRadio: 10.0,isCircle: false, songRecently: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal()),
        
                    const SizedBox(height: 10,),
                    // Title Carousel
                    const _TitleCarousel(left: 20, top: 0, title: 'Playlist',),
                    // Carousel Card Playlist
                    const SizedBox(height: 20,),
                    CustomCardCarouselSquare(height: 150.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 15.0, borderRadio: 10.0,isCircle: false, songRecently: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal()),
        
                    const SizedBox(height: 10,),
                    // Title Carousel
                    const _TitleCarousel(left: 20, top: 0, title: 'Artist',),
                    // Carousel Card Playlist
                    const SizedBox(height: 20,),
                    CustomCardCarouselCircle(height: 130.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 20.0, borderRadio: 60.0,isCircle: true, songRecently: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal(),)
                  ],
                ),

                ref.watch(songInfoProvider).title != '' ?
                CustomSelectedSongBox(
                  id: ref.watch(songInfoProvider).id, 
                  title: ref.watch(songInfoProvider).title, 
                  artist: ref.watch(songInfoProvider).artist, 
                  path: ref.watch(songInfoProvider).path, 
                  color: ref.watch(interactiveColorProvider),
                  onTap: () => context.push('/playing-now'),
                  iconButton: IconButton(
                    onPressed: () => AudioContextManager.playAudio(ref.watch(songInfoProvider).path),
                    icon: const Icon(Icons.play_arrow)),
                  artwork: SizedBox(
                    height: 50,
                    width: 50,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: LoardArtwork(
                        id: ref.watch(songInfoProvider).id,
                        radius: 10,
                      ),
                    )
                  ),
                ) : Container(),
              ],
            ),
          ),
        ],
        
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

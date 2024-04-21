import 'package:audio_service/audio_service.dart';
import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/config/menu/navegation_item.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/screen/home/home.dart';
import 'package:muix_player/presentation/screen/library/library.dart';
import 'package:muix_player/presentation/screen/playing_now/playing_screen.dart';
import 'package:muix_player/presentation/screen/search/search.dart';
import 'package:muix_player/presentation/screen/widgets/background.dart';
import 'package:muix_player/presentation/widgets/list_item.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({ Key? key }) : super(key: key);

  @override
  CustomNavigationState createState() => CustomNavigationState();
}

class CustomNavigationState extends State<CustomNavigation> {

  int currentPageIndex = 0;
  final audioManager = getIt<AudioManager>();
  final dominateColor = DominateColor();
  bool isClic = true;
  int actualPosition = 0;
  int actualIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      
          const Background(),
          
          Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                border: Border.all(
                  color: Colors.white
                )
              ),
              child: NavigationBar(
                
                backgroundColor: Colors.transparent,
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                indicatorColor: Colors.transparent,
                selectedIndex: currentPageIndex,
                destinations: navigationItem,
              ).frosted(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                frostColor: AppMuixTheme.background.withOpacity(0.05),
                blur: 15,
              ),
            ),
            body: [
              const Home(),
              const Search(),
              const Library(),
            ][currentPageIndex],
          ),
          Positioned(
            bottom: 95,
            child: Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: isClic ? ValueListenableBuilder<MediaItem>(
                valueListenable: audioManager.currentSongTitleNotifier,
                builder: (_, currentSong,__) {
                  return ValueListenableBuilder<Color>(
                    valueListenable: dominateColor.color,
                    builder: (_, color, __) {
                      return ListItem(
                        title: Text(currentSong.title, maxLines: 1, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                        subtitle: Text(currentSong.artist ?? "", maxLines: 1, style: AppMuixTheme.textUrbanistMediumPrimary12,),
                        artwork: currentSong.id.isEmpty ? 
                        Image.asset(
                          'assets/images/placeholder_song.png',
                          height: 70.h,
                        ) :
                        QueryArtworkWidget(
                          id: int.parse(currentSong.id),
                          type: ArtworkType.AUDIO,
                          artworkBorder: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                          artworkHeight: 70.h,
                          keepOldArtwork: true,
                        ),
                        onTap: ( ) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const PlayingScreen(),
                          ),
                        ),
                        icon: IconButton(onPressed: audioManager.play, icon: const Iconify(Ri.play_fill, color: Colors.white, size: 30,)),
                        iconQueue: IconButton(
                          onPressed: () => setState(() {isClic = false;}), 
                          icon: const Iconify(IconParkOutline.music_menu, color: Colors.white,)
                        ),
                        enableIconQueue: true,
                        boxDecoration: BoxDecoration(
                          color: color,
                          border: Border.all(
                            color: Colors.white
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        imageBorderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10), 
                          right: Radius.zero
                        )
                      );
                    }
                  );
                }
              ): 
              ValueListenableBuilder<List<MediaItem>>(
                valueListenable: audioManager.playlistNotifier,
                builder: (_, playlistSongs, __) {
                  return CarouselSlider.builder(
                    itemCount: 20, 
                    options: CarouselOptions(
                      viewportFraction: 0.15,
                      initialPage: 1,
                      onPageChanged: (index, reason) {
                        actualPosition = index;
                        setState(() {
                          
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      final songs = playlistSongs[index];
                    
                      return Row(
                        children: [
                          InkWell(
                            onDoubleTap: () => setState(() {isClic = true;}),
                            onTap: () async {
                              dominateColor.color.value = await dominateColor.getDominantingColorImage(int.parse(songs.id), ArtworkType.AUDIO);
                              audioManager..skipToNextQueueItem(index)..play;
                            },
                            child: QueryArtworkWidget(
                              id: int.parse(songs.id),
                              type: ArtworkType.AUDIO,
                              artworkBorder: BorderRadius.circular(5),
                              keepOldArtwork: true,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              ),
            )
          ),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/carousel_music.dart';
import 'package:muix_player/presentation/widgets/recent_activity.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class Home extends ConsumerWidget {
const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SuperScaffold(
          appBar: SuperAppBar(
            title: const Text('Home', ),
            largeTitle: SuperLargeTitle(
              largeTitle: 'Hello, Misael',
              actions: [
               
                Container(
                  height: 35.w,
                  width: 35.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: IconButton(onPressed: (){}, icon: const Iconify(Jam.menu))
                )
              ]
            ),
            searchBar: SuperSearchBar(
              enabled: false,
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    recentActivity(),
                    const SizedBox(height: 10,),
                    recentActivity(),
                    const SizedBox(height: 10,),
                    recentActivity(),
                    const SizedBox(height: 30,),
                    const CarouselMusic(
                      labelLeft: Text("Most Played", textAlign: TextAlign.center,),
                      labelRight: Text("View All", textAlign: TextAlign.center,),
                    ),
                    const SizedBox(height: 5,),
                    carouselItem(
                      const Text(
                      'Most Played', textAlign: TextAlign.center, 
                      ), 
                      const Text('View All', textAlign: TextAlign.center, ), 10),
                    const SizedBox(height: 5,),
                    carouselItem(const Text('Playlist', textAlign: TextAlign.center, ), const Text('View All', textAlign: TextAlign.center, ), 10),
                    const SizedBox(height: 5,),
                    carouselItem(const Text('Artist', textAlign: TextAlign.center, ), const Text('View All', textAlign: TextAlign.center, ), 100),
                    SizedBox(height: 130.h,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Stack carouselItem(
    Text labelL,
    Text labelR,
    double radius,
  ) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            padEnds: false,
            enableInfiniteScroll: false,
            height: 145.h,
            viewportFraction: 0.5
          ),
          items: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/placeholder_song.png',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                    ImageFilteredLinearGradientBlur(
                      imageBlurred: Image.asset(
                        'assets/images/placeholder_song.png',
                        fit: BoxFit.cover,
                        height: 40.h,
                        alignment: Alignment.bottomCenter
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      child: SizedBox(
                        height: 20.h,
                        child: const Text('Better Off (Aone, pt. II)', textAlign: TextAlign.center, overflow: TextOverflow.fade,)
                      )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.expand,
                  children: [
                    // Image.asset(
                    //   'assets/images/better_off.jpg',
                    //   fit: BoxFit.cover,
                    //   height: 40.h,
                    //   alignment: Alignment.bottomCenter
                    // ),
                    ImageFilteredLinearGradientOpacity(
                      imageBlurred: Image.asset(
                        'assets/images/better_off.jpg',
                        fit: BoxFit.cover,
                        height: 40.h,
                        alignment: Alignment.bottomCenter
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      child: SizedBox(
                        height: 20.h,
                        child: const Text('Better Off (Aone, pt. II)', textAlign: TextAlign.center, overflow: TextOverflow.fade,)
                      )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/better_off.jpg',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                    // ImageFilteredLinearGradientBlur(
                    //   imageBlurred: Image.asset(
                    //     'assets/images/better_off.jpg',
                    //     fit: BoxFit.cover,
                    //     height: 40.h,
                    //     alignment: Alignment.bottomCenter
                    //   ),
                    // ),
                    Positioned(
                      bottom: 1,
                      child: SizedBox(
                        height: 20.h,
                        child: const Text('Better Off (Aone, pt. II)',  textAlign: TextAlign.center, overflow: TextOverflow.fade,)
                      )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          child: CustomCarouselIndicator(
            text: labelL,
            borderRadiusGeometry: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0) 
            ),
          )
        ),
        Positioned(
          right: 1,
          child: CustomCarouselIndicator(
            text: labelR,
            borderRadiusGeometry: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0) 
            ),
          )
        )
      ],
    );
  }

  Row recentActivity() {
    return const Row(
      children: [
        RecentActivity(),
        SizedBox(width: 10,),
        RecentActivity()
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class Home extends StatelessWidget {
const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SuperScaffold(
      appBar: SuperAppBar(
        title: Text('Home', style: AppMuixTheme.textTitleUrbanistRegular36,),
        largeTitle: SuperLargeTitle(
          largeTitle: 'Hello, Misael',
          textStyle: AppMuixTheme.textTitleUrbanistRegular36,
          actions: [
            Container(
              height: 35.w,
              width: 35.w,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 228, 211, 182),
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
                rowRecentActivity(
                  'Name', 'Playlist', 
                  20.0, 0.0, 0.0, 20.0,
                  0.0, 20.0, 20.0, 0.0
                ),
                const SizedBox(height: 10,),
                rowRecentActivity(
                  'Name', 'Playlist', 
                  0.0, 20.0, 20.0, 0.0,
                  20.0, 0.0, 0.0, 20.0,
                ),
                const SizedBox(height: 10,),
                rowRecentActivity(
                  'Name', 'Playlist', 
                  20.0, 0.0, 0.0, 20.0,
                  0.0, 20.0, 20.0, 0.0
                ),
                const SizedBox(height: 10,),
                rowRecentActivity(
                  'Name', 'Playlist', 
                  0.0, 20.0, 20.0, 0.0,
                  20.0, 0.0, 0.0, 20.0,
                ),
                const SizedBox(height: 30,),

                carouselItem(
                  Text(
                  'Most Played', textAlign: TextAlign.center, 
                  style: AppMuixTheme.textUrbanistMediumPrimary12,), 
                  Text('View All', textAlign: TextAlign.center, style: AppMuixTheme.textUrbanistMediumPrimary12), 10),
                const SizedBox(height: 5,),
                carouselItem(Text('Playlist', textAlign: TextAlign.center, style: AppMuixTheme.textUrbanistMediumPrimary12), Text('View All', textAlign: TextAlign.center, style: AppMuixTheme.textUrbanistMediumPrimary12), 10),
                const SizedBox(height: 5,),
                carouselItem(Text('Artist', textAlign: TextAlign.center, style: AppMuixTheme.textUrbanistMediumPrimary12), Text('View All', textAlign: TextAlign.center, style: AppMuixTheme.textUrbanistMediumPrimary12), 100),
                SizedBox(height: 130.h,),
              ],
            ),
          ),
        ),
      ),
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
                        child: Text('Better Off (Aone, pt. II)', style: AppMuixTheme.textUrbanistMedium12, textAlign: TextAlign.center, overflow: TextOverflow.fade,)
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
                        child: Text('Better Off (Aone, pt. II)', style: AppMuixTheme.textUrbanistMedium12, textAlign: TextAlign.center, overflow: TextOverflow.fade,)
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
                        child: Text('Better Off (Aone, pt. II)', style: AppMuixTheme.textUrbanistMedium12, textAlign: TextAlign.center, overflow: TextOverflow.fade,)
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

  Row rowRecentActivity(
    String titleL, String titleR,
    double topLeftL, double topRightL,
    double bottomLeftL, double bottomRightL,
    double topLeftR, double topRightR,
    double bottomLeftR, double bottomRightR,
  ) {
    return Row(
      children: [
        CustomBoxActivity(
          title: titleL,
          height: 40.h, 
          topLeft: topLeftL, 
          topRight: topRightL, 
          bottomLeft: bottomLeftL, 
          bottomRight: bottomRightL,
          image: Image.asset(
            'assets/images/better_off.jpg',
            fit: BoxFit.cover,
            height: 40.h,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        CustomBoxActivity(
          title: titleR,
          height: 40.h, 
          topLeft: topLeftR, 
          topRight: topRightR, 
          bottomLeft: bottomLeftR, 
          bottomRight: bottomRightR,
          image: Image.asset(
            'assets/images/better_off.jpg',
            fit: BoxFit.cover,
            height: 40.h,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/carousel_music.dart';
import 'package:muix_player/presentation/widgets/recent_activity.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:provider/provider.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class Home extends ConsumerWidget {
const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muixTheme = context.read<MuixTheme>();
    return Column(
      children: [
        SuperScaffold(
          appBar: SuperAppBar(
            title: Text('Home', style: muixTheme.styleUrbanist36WhiteW500,),
            largeTitle: SuperLargeTitle(
              height: 65,
              textStyle: muixTheme.styleUrbanist36WhiteW500,
              largeTitle: 'Hello, Misael',
              actions: [
                BlurContainer(
                  borderRadius: BorderRadius.circular(18),
                  child: IconButton(
                    onPressed: (){}, 
                    icon: Iconify(Jam.menu, color: muixTheme.colorWhite,)
                  )
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
                    recentActivity(muixTheme),
                    const SizedBox(height: 10,),
                    recentActivity(muixTheme),
                    const SizedBox(height: 10,),
                    recentActivity(muixTheme),
                    const SizedBox(height: 30,),
                    carouselMusic(muixTheme),
                    const SizedBox(height: 5,),
                    carouselMusic(muixTheme),
                    const SizedBox(height: 5,),
                    carouselMusic(muixTheme),
                    const SizedBox(height: 5,),
                    carouselMusic(muixTheme),
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

  CarouselMusic carouselMusic(MuixTheme muixTheme) {
    return CarouselMusic(
      labelLeft: Text(
        "Most Played", 
        textAlign: TextAlign.center,
        style: muixTheme.styleUrbanist11WhiteW600,
      ),
      labelRight: Text(
        "View All", 
        textAlign: TextAlign.center,
        style: muixTheme.styleUrbanist11WhiteW600,
      ),
    );
  }

  Row recentActivity(MuixTheme muixTheme) {
    return Row(
      children: [
        RecentActivity(
          title: Text("Title very large, very large....jjjjjjjjjj", style: muixTheme.styleUrbanist12WhiteW600, maxLines: 1,),
        ),
        const SizedBox(width: 10,),
        RecentActivity(
          title: Text("Title very large, very large....jjjjjjjjjj", style: muixTheme.styleUrbanist12WhiteW600, maxLines: 1,)
        )
      ],
    );
  }
}
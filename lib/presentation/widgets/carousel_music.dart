import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:provider/provider.dart';

class CarouselMusic extends StatelessWidget {

  final Widget labelLeft;
  final Widget labelRight;

  const CarouselMusic({super.key, 
    required this.labelLeft, 
    required this.labelRight
  });

  @override
  Widget build(BuildContext context){
    final muixTheme = context.read<MuixTheme>();
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
            BoxItemMusic(
              title: Text("Title Music, Title Music, Title Music, Title Music, Title Music", style: muixTheme.styleUrbanist12WhiteW600,),
            ),
            BoxItemMusic(
              title: Text("Title Music", style: muixTheme.styleUrbanist12WhiteW600,),
            ),
            BoxItemMusic(
              title: Text("Title Music", style: muixTheme.styleUrbanist12WhiteW600,),
            ),
            BoxItemMusic(
              title: Text("Title Music", style: muixTheme.styleUrbanist12WhiteW600,),
            ),
          ],
        ),
        Positioned(
          child: BlurContainer(
            height: 25,
            width: 100,
            borderRadius: BorderRadius.circular(5),
            color: Colors.white.withOpacity(0.11),
            child: Center(child: labelLeft),
          )
        ),
        
        Positioned(
          right: 1,
          child: BlurContainer(
            height: 25,
            width: 100,
            borderRadius: BorderRadius.circular(5),
            color: Colors.white.withOpacity(0.11),
            child: Center(child: labelLeft),
          )
        ),
      ],
    );
  }
}
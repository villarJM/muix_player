import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';

class CarouselMusic extends StatelessWidget {

  final Widget labelLeft;
  final Widget labelRight;

  const CarouselMusic({super.key, 
    required this.labelLeft, 
    required this.labelRight
  });

  @override
  Widget build(BuildContext context){
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
                borderRadius: BorderRadius.circular(10),
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
                        child: const Text("")
                      )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10, sigmaY: 10
                      ),
                      child: Container(
                        color: Colors.white.withOpacity(0.1),
                        child: ImageFilteredLinearGradientOpacity(
                          imageBlurred: Image.asset(
                            'assets/images/better_off.jpg',
                            fit: BoxFit.cover,
                            height: 40.h,
                            alignment: Alignment.bottomCenter
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      child: SizedBox(
                        height: 20.h,
                        child: Text("")
                      )
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
                        child: Text("")
                      )
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30)
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft:  Radius.circular(25), topRight: Radius.circular(25)),
                          child: Image.asset(
                            'assets/images/better_off.jpg',
                            fit: BoxFit.cover,
                            width: 300,
                            alignment: Alignment.center
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadiusDirectional.only(bottomStart: Radius.circular(25), bottomEnd: Radius.circular(25)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10, sigmaY: 10
                          ),
                          child: Container(
                            height: 60,
                            color: Colors.white.withOpacity(0.11),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Positioned(
                    bottom: 1,
                    child: Text(""),
                  )
                ],
              ),
            )
          ],
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10, sigmaY: 10,
              ),
              child: Container(
                height: 25,
                width: 100,
                color: Colors.white.withOpacity(0.11),
                child: labelLeft,
              ),
            )
          )
        ),
        
        Positioned(
          right: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10, sigmaY: 10,
              ),
              child: Container(
                height: 25,
                width: 100,
                color: Colors.white.withOpacity(0.11),
                child: labelLeft,
              ),
            )
          )
        ),
      ],
    );
  }
}
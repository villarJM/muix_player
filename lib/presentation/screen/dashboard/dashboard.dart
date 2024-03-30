import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/custom_carousel_indicator.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class Dashboard extends StatelessWidget {
const Dashboard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20,),
          carouselItem(
            false,
            Alignment.topLeft, Alignment.topRight,
            0,0,
            'New Album', 'View All',
              0.0, 0.0, 0.0, 0.0,
              0.0, 0.0, 0.0, 0.0,
              0,0,
              1.0,
              0.0, 0.0, 0.0, 0.0,
          ),
          const SizedBox(height: 20,),
          carouselItem(
            true,
            Alignment.centerLeft, Alignment.centerRight,
            -1.57,-1.57,
            'New Album', 'View All',
              0.0, 10.0, 10.0, 0.0,
              10.0, 0.0, 0.0, 10.0,
              -20,-20,
              0.5,
              0.0, 0.0, 0.0, 0.0,
          ),
          const SizedBox(height: 5,),
          carouselItem(
            true,
            Alignment.centerLeft, Alignment.centerRight,
            -1.57,-1.57,
            'New Album', 'View All',
              0.0, 10.0, 10.0, 0.0,
              10.0, 0.0, 0.0, 10.0,
              -20,-20,
              0.5,
              0.0, 0.0, 0.0, 0.0,
          ),
        ],
      ),
    );
  }

  Stack carouselItem(
    bool enableIndicator,
    AlignmentGeometry alignmentL, AlignmentGeometry alignmentR,
    double angleL, double angleR,
    String labelL, String labelR,
    double indicatorBorderRadiusLTL, double indicatorBorderRadiusLTR,
    double indicatorBorderRadiusLBL, double indicatorBorderRadiusLBR,
    double indicatorBorderRadiusRTL, double indicatorBorderRadiusRTR,
    double indicatorBorderRadiusRBL, double indicatorBorderRadiusRBR,
    double left, double right,
    double viewportFraction,
    double itemBorderRadiusTL, double itemBorderRadiusTR,
    double itemBorderRadiusBL, double itemBorderRadiusBR,
  ) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CarouselSlider(
            options: CarouselOptions(
              padEnds: false,
              enableInfiniteScroll: false,
              height: 160.h,
              viewportFraction: viewportFraction,
            ),
            items: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(itemBorderRadiusTL),
                    topRight: Radius.circular(itemBorderRadiusTR),
                    bottomLeft: Radius.circular(itemBorderRadiusBL),
                    bottomRight: Radius.circular(itemBorderRadiusBR),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/better_off.jpg',
                        fit: BoxFit.cover,
                        height: 40.h,
                        alignment: Alignment.center
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
                          child: Text('Better Off (Aone, pt. II)', style: AppMuixTheme.textUrbanistMedium12, overflow: TextOverflow.fade,)
                        )
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(itemBorderRadiusTL),
                    topRight: Radius.circular(itemBorderRadiusTR),
                    bottomLeft: Radius.circular(itemBorderRadiusBL),
                    bottomRight: Radius.circular(itemBorderRadiusBR),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/better_off.jpg',
                        fit: BoxFit.cover,
                        height: 40.h,
                        alignment: Alignment.center
                      ),
                      // ImageFilteredLinearGradientOpacity(
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
                          child: Text('Better Off (Aone, pt. II)', style: AppMuixTheme.textUrbanistMedium12, overflow: TextOverflow.fade,)
                        )
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(itemBorderRadiusTL),
                    topRight: Radius.circular(itemBorderRadiusTR),
                    bottomLeft: Radius.circular(itemBorderRadiusBL),
                    bottomRight: Radius.circular(itemBorderRadiusBR),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/better_off.jpg',
                        fit: BoxFit.cover,
                        height: 40.h,
                        alignment: Alignment.center
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
                          child: Text('Better Off (Aone, pt. II)', style: AppMuixTheme.textUrbanistMedium12, overflow: TextOverflow.fade,)
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        enableIndicator == true ?
        Positioned.fill(
          left: left,
          child: Align(
            alignment: alignmentL,
            child: Transform.rotate(
              angle: angleL,
              child: CustomCarouselIndicator(
                label: labelL,
                style: AppMuixTheme.textUrbanistMedium12,
                borderRadiusTL: indicatorBorderRadiusLTL,
                borderRadiusTR: indicatorBorderRadiusLTR,
                borderRadiusBL: indicatorBorderRadiusLBL,
                borderRadiusBR: indicatorBorderRadiusLBR,
              ),
            ),
          )
        ) : Container(),
        enableIndicator == true ?
        Positioned.fill(
          right: right,
          child: Align(
            alignment: alignmentR,
            child: Transform.rotate(
              angle: angleR,
              child: CustomCarouselIndicator(
                label: labelR,
                style: AppMuixTheme.textUrbanistMedium12,
                borderRadiusTL: indicatorBorderRadiusRTL,
                borderRadiusTR: indicatorBorderRadiusRTR,
                borderRadiusBL: indicatorBorderRadiusRBL,
                borderRadiusBR: indicatorBorderRadiusRBR,
              ),
            ),
          )
        ) : Container(),
      ],
    );
  }
}
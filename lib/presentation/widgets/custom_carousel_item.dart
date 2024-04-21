import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/presentation/widgets/custom_carousel_indicator.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomCarouselItem extends StatelessWidget {

  final bool enableIndicator;
  final double angleL; 
  final double angleR;
  final Text labelL; 
  final Text labelR;
  final double left;
  final double right;
  final double viewportFraction;
  final AlignmentGeometry alignmentL; 
  final AlignmentGeometry alignmentR;
  final BorderRadius borderRadiusGeometry;
  final BorderRadius borderRadiusGeometryIndicatorL;
  final BorderRadius borderRadiusGeometryIndicatorR;
  final List<dynamic> listItem;
  
const CustomCarouselItem(
  { Key? key, 
  this.enableIndicator = false, 
  this.angleL = -1.57, 
  this.angleR = -1.57, 
  this.labelL = const Text('Text Label'), 
  this.labelR = const Text('View All'), 
  this.left = -20, 
  this.right = -20, 
  required this.viewportFraction, 
  required this.alignmentL, 
  required this.alignmentR, 
  this.borderRadiusGeometry = BorderRadius.zero, 
  this.borderRadiusGeometryIndicatorL = BorderRadius.zero, 
  this.borderRadiusGeometryIndicatorR = BorderRadius.zero,
  required this.listItem,
}) : super(key: key);

  @override
  Widget build(BuildContext context){
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
            items: listItem.map((e) => Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ClipRRect(
                borderRadius: borderRadiusGeometry,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  fit: StackFit.expand,
                  children: [
                    GlassContainer(
                      height: 160.h,
                      width: double.infinity,
                      blur: 5,
                      gradient: LinearGradient(
                        colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderGradient: LinearGradient(
                        colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.0, 0.39, 0.40, 1.0],
                      ),
                      borderWidth: 1.2,
                      borderRadius: BorderRadius.circular(20),
                      child: QueryArtworkWidget(
                        id: e.id, 
                        type: ArtworkType.AUDIO,
                        artworkBorder: BorderRadius.zero,
                        keepOldArtwork: true,
                        size: 1800,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: SizedBox(
                        height: 20.h,
                        child: Text(e.title, style: AppMuixTheme.textUrbanistMedium12, overflow: TextOverflow.fade,)
                      )
                    )
                  ],
                ),
              ),
            ),
            
            ).toList(),
            
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
                text: labelL,
                borderRadiusGeometry: borderRadiusGeometryIndicatorL,
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
                text: labelR,
                borderRadiusGeometry: borderRadiusGeometryIndicatorR,
              ),
            ),
          )
        ) : Container(),
      ],
    );
  }
}
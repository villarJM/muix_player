import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/presentation/widgets/custom_carousel_indicator.dart';
import 'package:muix_player/presentation/widgets/load_artwork.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomCarouselItem extends StatefulWidget {

  final bool enableIndicator;
  final Function()? indicatorOnTap;
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
  this.indicatorOnTap,
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
  State<CustomCarouselItem> createState() => _CustomCarouselItemState();
}

class _CustomCarouselItemState extends State<CustomCarouselItem> with AutomaticKeepAliveClientMixin {
  List<int> listEmpty = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context){
    super.build(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CarouselSlider(
            options: CarouselOptions(
              padEnds: false,
              enableInfiniteScroll: false,
              height: 160.h,
              viewportFraction: widget.viewportFraction,
            ),
            items: widget.listItem.isNotEmpty ? 
            widget.listItem.map((e) => viewContainer(e),).toList() : 
            listEmpty.map((e) => viewContainer(e)).toList()
          ),
        ),

        widget.enableIndicator == true ?
        Positioned.fill(
          left: widget.left,
          child: Align(
            alignment: widget.alignmentL,
            child: Transform.rotate(
              angle: widget.angleL,
              child: CustomCarouselIndicator(
                text: widget.labelL,
                borderRadiusGeometry: widget.borderRadiusGeometryIndicatorL,
              ),
            ),
          )
        ) : Container(),
        widget.enableIndicator == true ?
        Positioned.fill(
          right: widget.right,
          child: Align(
            alignment: widget.alignmentR,
            child: Transform.rotate(
              angle: widget.angleR,
              child: CustomCarouselIndicator(
                text: widget.labelR,
                borderRadiusGeometry: widget.borderRadiusGeometryIndicatorR,
                indicatorOnTap: widget.indicatorOnTap
              ),
            ),
          )
        ) : Container(),
      ],
    );
  }

  Padding viewContainer(e) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: ClipRRect(
        borderRadius: widget.borderRadiusGeometry,
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.expand,
          children: [
            GlassContainer(
              key: Key(e is int ? '$e' : e is SongModel ? '${(e).id}' : '${(e as PlaylistModel).id}'),
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
              child: LoadArtwork(
                id: (e is int ? e : e is SongModel ? (e).id : (e as PlaylistModel).id), 
                artworkType: ArtworkType.AUDIO,
                size: 1800,
                quality: FilterQuality.high,
              ),
            ),
            Positioned(
              bottom: 10,
              child: SizedBox(
                height: 20.h,
                child: Text(e is int ? "" : e is SongModel ? (e).title : (e as PlaylistModel).playlist, style: AppMuixTheme.textUrbanistMedium12, overflow: TextOverflow.fade,)
              )
            )
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
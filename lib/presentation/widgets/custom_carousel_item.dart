import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';
import 'package:muix_player/presentation/widgets/custom_carousel_indicator.dart';
import 'package:muix_player/presentation/widgets/load_artwork.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class CustomCarouselItem extends StatefulWidget {

  final bool enableIndicator;
  final Function()? indicatorOnTap;
  final Text labelLeft; 
  final Text labelRight;
  final double viewportFraction;
  final BorderRadius borderRadiusGeometry;
  final BorderRadius borderRadiusIndicatorL;
  final BorderRadius borderRadiusIndicatorR;
  final List<dynamic> listItem;
  
const CustomCarouselItem(
  { Key? key, 
  this.enableIndicator = false,
  this.indicatorOnTap, 
  this.labelLeft = const Text('Text Label'), 
  this.labelRight = const Text('View All'), 
  required this.viewportFraction, 
  this.borderRadiusGeometry = BorderRadius.zero, 
  this.borderRadiusIndicatorL = BorderRadius.zero, 
  this.borderRadiusIndicatorR = BorderRadius.zero,
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

        Visibility(
          visible: widget.enableIndicator,
          child: Positioned.fill(
            left: - 10,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Transform.rotate(
                angle: 270 * (3.1416 / 180),
                child: CustomCarouselIndicator(
                  text: widget.labelLeft,
                  borderRadius: widget.borderRadiusIndicatorL,
                )
              ),
            ),
          ),
        ),

        Visibility(
          visible: widget.enableIndicator,
          child: Positioned.fill(
            right: - 10,
            child: Align(
              alignment: Alignment.centerRight,
              child: Transform.rotate(
                angle: 270 * (3.1416 / 180),
                child: CustomCarouselIndicator(
                  text: widget.labelRight,
                  borderRadius: widget.borderRadiusIndicatorR,
                )
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding viewContainer(e) {
    final muixTheme = context.read<MuixTheme>();
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: ClipRRect(
        borderRadius: widget.borderRadiusGeometry,
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.expand,
          children: [
            BlurContainer(
              key: Key(e is int ? '$e' : e is SongModel ? '${(e).id}' : '${(e as PlaylistModel).id}'),
              child: LoadArtwork(
                id: (e is int ? e : e is SongModel ? (e).id : (e as PlaylistModel).id), 
                artworkType: ArtworkType.AUDIO,
                size: 1800,
                quality: FilterQuality.high,
              ),
            ),
            Positioned(
              bottom: 10,
              child: BlurContainer(
                borderRadius: BorderRadius.circular(8),
                height: 25,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
                  child: Text(e is int ? "Music" : e is SongModel ? (e).title : (e as PlaylistModel).playlist, overflow: TextOverflow.ellipsis, style: muixTheme.styleUrbanist12WhiteW600,),
                )
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
import 'package:flutter/material.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';

class CustomCarouselIndicator extends StatelessWidget {

  final double height;
  final double width;
  final double paddingAll;
  final Widget? text;
  final Function()? onTap;
  final BorderRadius borderRadius;

const CustomCarouselIndicator({ 
  Key? key, 
  this.height = 25, 
  this.width = 100, 
  this.paddingAll = 4,
  required this.text,
  this.onTap,
  this.borderRadius = BorderRadius.zero,
}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlurContainer(
      borderRadius: borderRadius,
      height: height,
      width: width,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(paddingAll),
          child: text,
        )
      ),
    );
  }
}
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselIndicator extends StatelessWidget {

  final double height;
  final double width;
  final double paddingAll;
  final Color colorBorder;
  final Widget? text;
  final Function()? indicatorOnTap;
  final double blur;
  final BorderRadius borderRadiusGeometry;

const CustomCarouselIndicator({ 
  Key? key, 
  this.height = 20, 
  this.width = 80, 
  this.paddingAll = 4, 
  this.colorBorder = Colors.white, 
  required this.text,
  this.indicatorOnTap,
  this.blur = 5,
  this.borderRadiusGeometry = BorderRadius.zero,
}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      height: height.h,
      width: width.w,
      padding: EdgeInsets.all(paddingAll),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorBorder
        )
      ),
      child: InkWell(
        onTap: indicatorOnTap,
        child: text
      ),
    ).frosted(
      blur: blur,
      borderRadius: borderRadiusGeometry,
    );
  }
}
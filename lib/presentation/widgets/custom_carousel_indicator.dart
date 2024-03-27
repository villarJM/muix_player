import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarouselIndicator extends StatelessWidget {

  final double height;
  final double width;
  final double paddingAll;
  final Color colorBorder;
  final String label;
  final TextStyle? style;
  final double blur;
  final double borderRadiusTL;
  final double borderRadiusTR;
  final double borderRadiusBL;
  final double borderRadiusBR;

const CustomCarouselIndicator({ 
  Key? key, 
  this.height = 20, 
  this.width = 80, 
  this.paddingAll = 4, 
  this.colorBorder = Colors.white, 
  required this.label, 
  this.style,
  this.blur = 5,
  required this.borderRadiusTL, 
  required this.borderRadiusTR, 
  required this.borderRadiusBL, 
  required this.borderRadiusBR 
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
      child: Text(label, style: style, textAlign: TextAlign.center),
    ).frosted(
      blur: blur,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadiusTL),
        topRight: Radius.circular(borderRadiusTR),
        bottomLeft: Radius.circular(borderRadiusBL), 
        bottomRight: Radius.circular(borderRadiusBR), 
      ),
    );
  }
}
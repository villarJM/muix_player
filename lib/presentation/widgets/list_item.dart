import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
 class ListItem extends StatelessWidget {
  final double height;
  final Text title;
  final Text subtitle;
  final Widget? artwork;
  final Function()? onTap;
  final Widget icon;
  final Widget? iconQueue;
  final bool enableIconQueue;
  final BorderRadius borderRadius;
  final BorderRadiusGeometry imageBorderRadius;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final bool isGlass;

 const ListItem({ Key? key, 
  this.height = 45,
  required this.title, 
  required this.subtitle, 
  this.artwork,
  this.onTap,
  required this.icon,
  this.iconQueue,
  this.enableIconQueue = false,
  this.borderRadius = BorderRadius.zero,
  this.imageBorderRadius = BorderRadius.zero,
  this.gradient = const LinearGradient(
    colors: [Colors.white38, Colors.white10],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  this.borderGradient = const LinearGradient(
      colors: [Colors.white60, Colors.white10, Colors.white10, Colors.white60],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 0.39, 0.40, 1.0],
    ),
  this.isGlass = false,
  }) : super(key: key);
 
   @override
   Widget build(BuildContext context){
     return InkWell(
      onTap: onTap,
       child: GlassContainer(
        height: height,
        width: double.infinity,
        blur: 5,
        gradient: gradient,
        borderGradient: borderGradient,
        borderWidth: 1.2,
        margin: const EdgeInsets.only(top: 3),
        borderRadius: borderRadius,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: imageBorderRadius,
              child: artwork,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title,
                    subtitle
                  ],
                ),
              ),
            ),
            enableIconQueue ? iconQueue! : Container(),
            icon
          ],
        ),
           ),
     );
   }
 }
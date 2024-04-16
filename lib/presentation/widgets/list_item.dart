import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 class ListItem extends StatelessWidget {
  final Text title;
  final Text subtitle;
  final Widget artwork;
  final Function()? onTap;
  final Widget icon;
  final Widget? iconQueue;
  final bool enableIconQueue;
  final BoxDecoration boxDecoration;
  final BorderRadiusGeometry imageBorderRadius;

 const ListItem({ Key? key, 
  required this.title, 
  required this.subtitle, 
  required this.artwork,
  this.onTap,
  required this.icon,
  this.iconQueue,
  this.enableIconQueue = false,
  this.boxDecoration = const BoxDecoration(color: Colors.white),
  this.imageBorderRadius = BorderRadius.zero,
  }) : super(key: key);
 
   @override
   Widget build(BuildContext context){
     return InkWell(
      onTap: onTap,
       child: Container(
        margin: const EdgeInsets.only(top: 3),  
        height: 45.h,
        decoration: boxDecoration,
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
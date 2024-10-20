import 'package:flutter/material.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';
 class ListItem extends StatelessWidget {
  final double height;
  final Text title;
  final Text subtitle;
  final Widget? artwork;
  final Function()? onTap;
  final Widget icon;
  final BorderRadius borderRadius;
  final BorderRadiusGeometry borderRadiusArtwork;

 const ListItem({ Key? key, 
  this.height = 45,
  required this.title, 
  required this.subtitle, 
  this.artwork,
  this.onTap,
  required this.icon,
  this.borderRadius = BorderRadius.zero,
  this.borderRadiusArtwork = BorderRadius.zero
  }) : super(key: key);
 
   @override
   Widget build(BuildContext context){
     return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
       child: BlurContainer(
        height: height,
        borderRadius: borderRadius,
         child: Row(
           children: [
             ClipRRect(
               borderRadius: borderRadiusArtwork,
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
             icon
           ],
         ),
       ),
     );
   }
 }
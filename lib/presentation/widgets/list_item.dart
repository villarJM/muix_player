import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 class ListItem extends StatelessWidget {
  final Text title;
  final Text subtitle;
  final Widget artwork;
  final double borderRadiusTopLeft;
  final double borderRadiusTopRight;
  final double borderRadiusBottomLeft;
  final double borderRadiusBottomRight;

 const ListItem({ Key? key, 
  required this.title, 
  required this.subtitle, 
  required this.artwork, 
  required this.borderRadiusTopLeft, 
  required this.borderRadiusTopRight, 
  required this.borderRadiusBottomLeft, 
  required this.borderRadiusBottomRight 
  }) : super(key: key);
 
   @override
   Widget build(BuildContext context){
     return Container(
      margin: const EdgeInsets.only(top: 3),
      height: 45.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadiusTopLeft),
          topRight: Radius.circular(borderRadiusTopRight),
          bottomLeft: Radius.circular(borderRadiusBottomLeft),
          bottomRight: Radius.circular(borderRadiusBottomRight),
        ),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 5, 23, 39), Color.fromARGB(200, 228, 211, 182),Color.fromARGB(255, 228, 211, 182),],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadiusTopLeft-1),
              topRight: Radius.circular(borderRadiusTopRight-1),
              bottomLeft: Radius.circular(borderRadiusBottomLeft-1),
              bottomRight: Radius.circular(borderRadiusBottomRight-1),
            ),
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
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
        ],
      ),
    );
   }
 }
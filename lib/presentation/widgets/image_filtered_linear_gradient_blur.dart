import 'dart:ui';

import 'package:flutter/material.dart';
 
 class ImageFilteredLinearGradientBlur extends StatelessWidget {

  final Widget? imageBlurred;
 const ImageFilteredLinearGradientBlur({ Key? key, this.imageBlurred }) : super(key: key);
 
   @override
   Widget build(BuildContext context){
     return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.black.withOpacity(0)],
            stops: const [0.3, 0.75]
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: imageBlurred,
      )
    );
   }
 }
import 'dart:ui';

import 'package:flutter/material.dart';

class ImageFilteredLinearGradientOpacity extends StatelessWidget {
  final Widget? imageBlurred;
const ImageFilteredLinearGradientOpacity({ Key? key, this.imageBlurred }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.black.withOpacity(0)],
            stops: const [0.1, 1.0]
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: imageBlurred,
      )
    );
  }
}
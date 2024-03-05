import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class ScreenBlur extends StatelessWidget {
const ScreenBlur({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Container(
          color: AppMuixTheme.background,
        ),
        Transform.translate(
          offset: const Offset(-120, -240),
          child: Container(
              height: 450.h,
              width: 450.w,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  transform: GradientRotation(1),
                  colors: [
                    Color.fromARGB(255, 220, 48, 240),
                    Color.fromARGB(255, 100, 0, 217),
                  ]
                ),
                shape: BoxShape.circle,
              ),
          )
        ),
        Transform.translate(
          offset: const Offset(190, 400),
          child: Container(
              height: 450.h,
              width: 450.w,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  transform: GradientRotation(3),
                  colors: [
                    Color.fromARGB(255, 165, 119, 0),
                    Color.fromARGB(255, 141, 0, 59),
                  ]
                ),
                shape: BoxShape.circle,
              ),
          )
        ),
        Blur(
          blur: 40,
          blurColor: Colors.white10,
          colorOpacity: 0.1,
          child: Container(),
        ),
      ],
    );
  }
}
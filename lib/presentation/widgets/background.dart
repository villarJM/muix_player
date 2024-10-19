import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Background extends StatelessWidget {
const Background({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xFF03093A),
      body: Stack(
        children: [
          Positioned(
            top: -260,
            left: -140,
            child: ClipOval(
              child: Container(
                height: 437.h,
                width: 309.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF005D9E),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -300,
            left: -70,
            child: ClipOval(
              child: Container(
                height: 450.h,
                width: 254.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF7A3507),
                ),
              ).blurred(
                blurColor: const Color(0xFF7A1207)
              ),
            ),
          )
        ],
      )
      .blurred(
        blur: 300,
        colorOpacity: 0
      ),
    );
  }
}
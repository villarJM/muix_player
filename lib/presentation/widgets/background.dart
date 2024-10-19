import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Background extends StatelessWidget {
const Background({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0XFFFFBFB6),
      body: Stack(
        children: [
          Positioned(
            top: -150,
            left: -170,
            child: ClipOval(
              child: Container(
                height: 437.h,
                width: 309.w,
                decoration: const BoxDecoration(
                  color: Color(0XFFFFE2AE),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -70,
            child: ClipOval(
              child: Container(
                height: 450.h,
                width: 254.w,
                decoration: const BoxDecoration(
                  color: Color(0XFFEAC1FD),
                ),
              ),
            ),
          )
        ],
      )
      .blurred(
        blur: 100,
        colorOpacity: 0
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Albums extends StatelessWidget {
const Albums({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [
          SizedBox(
            height: 205,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/better_off.jpg',
                fit: BoxFit.cover,
                height: 40.h,
                alignment: Alignment.bottomCenter
              ),
            ),
          ),
          SizedBox(
            height: 205,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/better_off.jpg',
                fit: BoxFit.cover,
                height: 40.h,
                alignment: Alignment.bottomCenter
              ),
            ),
          ),
          SizedBox(
            height: 205,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/better_off.jpg',
                fit: BoxFit.cover,
                height: 40.h,
                alignment: Alignment.bottomCenter
              ),
            ),
          ),
          SizedBox(
            height: 205,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/better_off.jpg',
                fit: BoxFit.cover,
                height: 40.h,
                alignment: Alignment.bottomCenter
              ),
            ),
          ),
          SizedBox(
            height: 205,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/better_off.jpg',
                fit: BoxFit.cover,
                height: 40.h,
                alignment: Alignment.bottomCenter
              ),
            ),
          ),
          SizedBox(
            height: 205,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/better_off.jpg',
                fit: BoxFit.cover,
                height: 40.h,
                alignment: Alignment.bottomCenter
              ),
            ),
          ),
          SizedBox(
            height: 205,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/better_off.jpg',
                fit: BoxFit.cover,
                height: 40.h,
                alignment: Alignment.bottomCenter
              ),
            ),
          ),
          SizedBox(
            height: 205,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/better_off.jpg',
                fit: BoxFit.cover,
                height: 40.h,
                alignment: Alignment.bottomCenter
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:ui';

import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
const RecentActivity({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusDirectional.horizontal(start: Radius.circular(15)),
            child: Image.asset(
              'assets/images/better_off.jpg',
              fit: BoxFit.cover,
              height: 50,
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadiusDirectional.horizontal(end: Radius.circular(15)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10, sigmaY: 10
                ),
                child: Container(
                  height: 50,
                  color: Colors.white.withOpacity(0.11),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Title"),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
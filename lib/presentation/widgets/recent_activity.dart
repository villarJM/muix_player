import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';

class RecentActivity extends StatelessWidget {

  final Widget title;

  const RecentActivity({ 
    Key? key, 
    required this.title 
  }) : super(key: key);

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
            child: BlurContainer(
              borderRadius: const BorderRadiusDirectional.horizontal(end: Radius.circular(15)),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: title,
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
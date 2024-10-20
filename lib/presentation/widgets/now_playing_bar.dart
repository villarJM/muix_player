import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';

class NowPlayingBar extends StatelessWidget {

  final BorderRadiusGeometry borderRadiusArtwork;
  final Color backgroundColor;
  final double height;
  final double opacity;
  final Widget artwork;
  final Widget icon;
  final Widget subtitle;
  final Widget title;

  const NowPlayingBar({ 
    Key? key, 
    required this.artwork, 
    required this.icon,
    required this.subtitle, 
    required this.title, 
    this.backgroundColor = Colors.white, 
    this.borderRadiusArtwork = BorderRadius.zero,
    this.height = 55, 
    this.opacity = 0.15, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: BlurContainer(
        borderRadius: BorderRadius.circular(15),
        height: height,
        color: backgroundColor.withOpacity(opacity),
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
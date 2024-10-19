import 'dart:io';
import 'package:flutter/material.dart';
import 'package:muix_player/config/menu/navegation_item.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/screen/home/home.dart';
import 'package:muix_player/presentation/screen/library/library.dart';
import 'package:muix_player/presentation/screen/search/search_screen.dart';
import 'package:muix_player/presentation/widgets/background.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';
import 'package:muix_player/presentation/widgets/box_playing.dart';
import 'package:muix_player/services/audio_manager.dart';
import 'package:muix_player/services/service_locator.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({ Key? key }) : super(key: key);

  @override
  CustomNavigationState createState() => CustomNavigationState();
}

class CustomNavigationState extends State<CustomNavigation> {

  int currentPageIndex = 0;
  final audioManager = getIt<AudioManager>();
  final dominateColor = DominateColor();
  bool isClic = true;
  int actualPosition = 0;
  int actualIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Brightness brightness = ThemeData.estimateBrightnessForColor(ref.watch(colorStateProvider));
    return Scaffold(
      body: Stack(
        children: [
      
          const Background(),
          
          Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              height: 100,
              color: Colors.transparent,
              child: BlurContainer(
                borderRadius: BorderRadius.circular(30),
                height: 70,
                color: Colors.white.withOpacity(0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: navigationItem.map((item) 
                    => IconButton(
                      onPressed: () {
                        currentPageIndex = item.pageIndex;
                        setState(() {});
                      },
                      icon: currentPageIndex == item.pageIndex 
                        ? item.selectedIcon
                        : item.icon,
                    )
                  ).toList()
                ),
              ),
            ),
            body: [
              const Home(),
              const SearchScreen(),
              const Library(),
            ][currentPageIndex],
          ),
          BoxPlaying(
            pBottom: Platform.isAndroid ? 95 : 130,
          ),
        ],
      ),
    );
  }
}
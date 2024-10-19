import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/config/menu/navegation_item.dart';
import 'package:muix_player/presentation/providers/dominate_color.dart';
import 'package:muix_player/presentation/screen/home/home.dart';
import 'package:muix_player/presentation/screen/library/library.dart';
import 'package:muix_player/presentation/screen/search/search_screen.dart';
import 'package:muix_player/presentation/widgets/background.dart';
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
            bottomNavigationBar: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                border: Border.all(
                  color: Colors.white
                )
              ),
              child: NavigationBar(
                
                backgroundColor: Colors.transparent,
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                indicatorColor: Colors.transparent,
                selectedIndex: currentPageIndex,
                destinations: navigationItem,
              ).frosted(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                frostColor: const Color(0Xfffce4ac).withOpacity(0.05),
                blur: 15,
              ),
            ),
            body: [
              const Home(),
              const SearchScreen(),
              const Library(),
            ][currentPageIndex],
          ),
          const BoxPlaying(
            pBottom: 95,
          ),
        ],
      ),
    );
  }
}
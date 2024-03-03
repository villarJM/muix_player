import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/helper/iconify.dart';
import 'package:muix_player/presentation/screen/home/home.dart';
import 'package:muix_player/presentation/screen/library/library.dart';
import 'package:muix_player/presentation/screen/search/search.dart';
import 'package:muix_player/presentation/screen/widgets/screen_blur.dart';
import 'package:r_border/r_border.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({ Key? key }) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        const ScreenBlur(),
        
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: RBorder(
                top: RGradientLineBorderSide(
                  width: 1,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white54,
                      Colors.white,
                    ],
                  ),
                )
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
              blur: 10,
            ),
          ),
          body: [
            const Home(),
            const Search(),
            const Library(),
          ][currentPageIndex],
        ),
      ],
    );
  }
}
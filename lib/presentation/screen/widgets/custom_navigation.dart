import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/helper/iconify.dart';
import 'package:muix_player/presentation/screen/home/home.dart';
import 'package:muix_player/presentation/screen/library/library.dart';
import 'package:muix_player/presentation/screen/search/search.dart';
import 'package:muix_player/presentation/screen/widgets/background.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({ Key? key }) : super(key: key);

  @override
  CustomNavigationState createState() => CustomNavigationState();
}

class CustomNavigationState extends State<CustomNavigation> {

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        const Background(),
        
        Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          bottomNavigationBar:
          Container(
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
              frostColor: AppMuixTheme.background.withOpacity(0.05),
              blur: 15,
            ),
          ),
          body: [
            const Home(),
            const Search(),
            const Library(),
          ][currentPageIndex],
        )
        // Scaffold(
        //   backgroundColor: Colors.transparent,
        //   bottomNavigationBar: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        //     ),
        //     margin: const EdgeInsets.fromLTRB(10, 0, 10, 10.0),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        //         border: Border.all(
        //           width: 2,
        //           color: Colors.transparent
        //       ),
        //         gradient: LinearGradient(
        //           colors: [
        //             Colors.white,
        //             Colors.white.withOpacity(0.1),
        //             Colors.white,
        //           ],
        //           begin: Alignment.bottomRight,
        //           end: Alignment.topLeft,
        //         )
        //       ),
        //       child: ClipRRect(
        //         borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        //         child: NavigationBar(
        //           backgroundColor: Colors.transparent,
        //           onDestinationSelected: (int index) {
        //             setState(() {
        //               currentPageIndex = index;
        //             });
        //           },
        //           indicatorColor: Colors.transparent,
        //           selectedIndex: currentPageIndex,
        //           destinations: navigationItem,
        //         ).frosted(
        //           blur: 10,
        //         ),
        //       ),
        //     ),
        //   ),
        //   body: [
        //     const Home(),
        //     const Search(),
        //     const Library(),
        //   ][currentPageIndex],
        // ),
      ],
    );
  }
}
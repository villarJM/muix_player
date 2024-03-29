import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/presentation/screen/all_songs/songs.dart';
import 'package:muix_player/presentation/screen/dashboard/dashboard.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class Library extends StatelessWidget {
const Library({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SuperScaffold(
      appBar: SuperAppBar(
        title: Text('Library', style: AppMuixTheme.textTitleUrbanistRegular36,),
        largeTitle: SuperLargeTitle(
          largeTitle: 'Library',
          textStyle: AppMuixTheme.textTitleUrbanistRegular36,
          actions: [
            IconButton(onPressed: (){}, icon: const Iconify(MaterialSymbols.folder_outline)),
            IconButton(onPressed: (){}, icon: const Iconify(Carbon.equalizer)),
            Container(
              height: 35.w,
              width: 35.w,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 228, 211, 182),
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10)
              ),
              child: IconButton(onPressed: (){}, icon: const Iconify(Jam.menu))
            ),
            
          ]
        ),
        searchBar: SuperSearchBar(enabled: false),
        backgroundColor: Colors.transparent,
      ),
      body: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: DefaultTabController(
            
            length: 5,
            
            child: Column(
              children: <Widget>[
                ButtonsTabBar(
                  height: 35,
                  borderWidth: 1,
                  unselectedBorderColor: Colors.white,
                  borderColor: Colors.white,
                  backgroundColor: AppMuixTheme.primary,
                  unselectedBackgroundColor: AppMuixTheme.background,
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.w,),
                  buttonMargin: EdgeInsets.symmetric(horizontal: 20.w,),
                  unselectedLabelStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: "Home",),
                    Tab(text: "Songs",),
                    Tab(text: "Albums",),
                    Tab(text: "Genres",),
                    Tab(text: "Playlist"),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Dashboard(),
                      Songs(),
                      
                      Center(
                        child: Icon(Icons.directions_bike),
                      ),
                      Center(
                        child: Icon(Icons.directions_car),
                      ),
                      Center(
                        child: Icon(Icons.directions_transit),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
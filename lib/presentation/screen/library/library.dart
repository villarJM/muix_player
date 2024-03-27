import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/screen/all_songs/all_songs.dart';
import 'package:muix_player/presentation/screen/dashboard/dashboard_player.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class Library extends StatelessWidget {
const Library({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Library', style: AppMuixTheme.textTitleUrbanistRegular36),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 5,
          
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                height: 35,
                contentPadding: EdgeInsets.symmetric(horizontal: 25.w,),
                buttonMargin: EdgeInsets.symmetric(horizontal: 20.w,),
                backgroundColor: Colors.red,
                unselectedBackgroundColor: Colors.white.withOpacity(0.5),
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                    DashboardPlayer(),
                    AllSongs(),
                    
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
    );
  }
}
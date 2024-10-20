import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/presentation/screen/albums/album.dart';
import 'package:muix_player/presentation/screen/all_songs/songs.dart';
import 'package:muix_player/presentation/screen/artists/artists.dart';
import 'package:muix_player/presentation/screen/dashboard/dashboard.dart';
import 'package:muix_player/presentation/screen/genres/genres.dart';
import 'package:muix_player/presentation/screen/playlist/playlist_screen.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:provider/provider.dart';

const List<Tab> tabs = [
  Tab(text: "Home",),
  Tab(text: "Songs",),
  Tab(text: "Albums",),
  Tab(text: "Artist",),
  Tab(text: "Genres",),
  Tab(text: "Playlist"),
];


class Library extends ConsumerStatefulWidget {
const Library({ Key? key }) : super(key: key);

  @override
  ConsumerState<Library> createState() => _LibraryState();
}

class _LibraryState extends ConsumerState<Library> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin{

  late TabController controller;

  @override
  void initState() {
    controller = TabController(initialIndex: 0 ,length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final muixTheme = context.read<MuixTheme>();
    super.build(context);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          title: Text('Library', style: muixTheme.styleUrbanist36WhiteW500,),
          actions: [
            BlurContainer(
              borderRadius: BorderRadius.circular(15),
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: (){}, 
                icon: const Iconify(
                  Carbon.equalizer,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            BlurContainer(
              borderRadius: BorderRadius.circular(15),
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: (){}, 
                icon: const Iconify(
                  MaterialSymbols.folder_outline,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            BlurContainer(
              borderRadius: BorderRadius.circular(15),
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: (){}, 
                icon: const Iconify(
                  Jam.menu,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20.w,)
          ],
          bottom: ButtonsTabBar(
            height: 35,
            borderWidth: 1,
            unselectedBorderColor: Colors.white,
            borderColor: Colors.transparent,
            backgroundColor: Colors.white.withOpacity(0.11),
            contentPadding: EdgeInsets.symmetric(horizontal: 25.w,),
            buttonMargin: EdgeInsets.symmetric(horizontal: 20.w,),
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            controller: controller,
            tabs: tabs,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: TabBarView(
          controller: controller,
          children:  [
            Dashboard(controller: controller,),
            const Songs(),
            const Albums(),
            const Artist(),
            const GenresScreen(),
            PlaylistScreen(tabController: controller,)
          ]
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
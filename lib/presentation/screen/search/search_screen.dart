import 'package:flutter/material.dart';
import 'package:muix_player/presentation/screen/search/sliver_search_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
const SearchScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final muixTheme = context.read<MuixTheme>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 80.h,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Search', style: muixTheme.styleUrbanist36WhiteW500,),
                expandedTitleScale: 1,
                titlePadding: const EdgeInsets.only(left: 15,),
              ),
              actions: [
                BlurContainer(
                    borderRadius: BorderRadius.circular(18),
                    child: IconButton(
                      onPressed: (){}, 
                      icon: Iconify(Jam.menu, color: muixTheme.colorWhite,)
                    )
                  )
              ],
              backgroundColor: Colors.transparent,
            ),
            SliverPersistentHeader(
              delegate: SliverSearchAppBar(),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              
              children: const [
                BoxItemMusic(title: Text("")),
                BoxItemMusic(title: Text("")),
                BoxItemMusic(title: Text("")),
                BoxItemMusic(title: Text("")),
                BoxItemMusic(title: Text("")),
                BoxItemMusic(title: Text("")),
                BoxItemMusic(title: Text("")),
                BoxItemMusic(title: Text("")),
                BoxItemMusic(title: Text("")),
              ],
            ),
          ],
        ),
      )
    );
  }
}
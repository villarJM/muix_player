import 'package:flutter/material.dart';
import 'package:muix_player/presentation/screen/search/sliver_search_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/helper/icons.dart';

class SearchScreen extends StatelessWidget {
const SearchScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 80.h,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('Search',),
                expandedTitleScale: 1,
                titlePadding: EdgeInsets.only(left: 15,),
              ),
              actions: [
                Container(
              height: 35.w,
              width: 35.w,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 228, 211, 182),
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10)
              ),
              child: IconButton(onPressed: (){}, icon: const Iconify(Jam.menu))
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
              
              children: [
                SizedBox(
                  height: 205,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/better_off.jpg',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                  ),
                ),
                SizedBox(
                  height: 205,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/better_off.jpg',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                  ),
                ),
                SizedBox(
                  height: 205,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/better_off.jpg',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                  ),
                ),
                SizedBox(
                  height: 205,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/better_off.jpg',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                  ),
                ),
                SizedBox(
                  height: 205,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/better_off.jpg',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                  ),
                ),
                SizedBox(
                  height: 205,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/better_off.jpg',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                  ),
                ),
                SizedBox(
                  height: 205,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/better_off.jpg',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                  ),
                ),
                SizedBox(
                  height: 205,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/better_off.jpg',
                      fit: BoxFit.cover,
                      height: 40.h,
                      alignment: Alignment.bottomCenter
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
    // return SuperScaffold(
    //   appBar: SuperAppBar(
    //     title: Text('Search', style: AppMuixTheme.textTitleUrbanistRegular36,),
    //     largeTitle: SuperLargeTitle(
    //       largeTitle: 'Search',
    //       textStyle: AppMuixTheme.textTitleUrbanistRegular36,
    //       actions: [
    //         Container(
    //           height: 35.w,
    //           width: 35.w,
    //           decoration: BoxDecoration(
    //             color: const Color.fromARGB(255, 228, 211, 182),
    //             border: Border.all(color: Colors.white),
    //             borderRadius: BorderRadius.circular(10)
    //           ),
    //           child: IconButton(onPressed: (){}, icon: const Iconify(Jam.menu))
    //         )
    //       ]
    //     ),
    //     searchBar: SuperSearchBar(
    //       placeholderText: 'Discover',
    //       backgroundColor: AppMuixTheme.background,
    //       height: 60,
    //       resultColor: AppMuixTheme.backgroundSecondary,
    //       prefixIcon: const Icon(Icons.search, size: 40, color: Colors.white, shadows: <Shadow>[Shadow(color: Colors.black12, blurRadius: 5.0)],)
    //     ),
    //     backgroundColor: Colors.transparent,
    //   ),
    //   body: Scaffold(
    //     backgroundColor: Colors.transparent,
    //     body: 
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 10),
    //       child: GridView.count(
    //         crossAxisCount: 2,
    //         crossAxisSpacing: 5,
    //         mainAxisSpacing: 5,
            
    //         children: [
    //           SizedBox(
    //             height: 205,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: Image.asset(
    //                 'assets/images/better_off.jpg',
    //                 fit: BoxFit.cover,
    //                 height: 40.h,
    //                 alignment: Alignment.bottomCenter
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 205,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: Image.asset(
    //                 'assets/images/better_off.jpg',
    //                 fit: BoxFit.cover,
    //                 height: 40.h,
    //                 alignment: Alignment.bottomCenter
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 205,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: Image.asset(
    //                 'assets/images/better_off.jpg',
    //                 fit: BoxFit.cover,
    //                 height: 40.h,
    //                 alignment: Alignment.bottomCenter
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 205,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: Image.asset(
    //                 'assets/images/better_off.jpg',
    //                 fit: BoxFit.cover,
    //                 height: 40.h,
    //                 alignment: Alignment.bottomCenter
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 205,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: Image.asset(
    //                 'assets/images/better_off.jpg',
    //                 fit: BoxFit.cover,
    //                 height: 40.h,
    //                 alignment: Alignment.bottomCenter
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 205,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: Image.asset(
    //                 'assets/images/better_off.jpg',
    //                 fit: BoxFit.cover,
    //                 height: 40.h,
    //                 alignment: Alignment.bottomCenter
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 205,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: Image.asset(
    //                 'assets/images/better_off.jpg',
    //                 fit: BoxFit.cover,
    //                 height: 40.h,
    //                 alignment: Alignment.bottomCenter
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 205,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: Image.asset(
    //                 'assets/images/better_off.jpg',
    //                 fit: BoxFit.cover,
    //                 height: 40.h,
    //                 alignment: Alignment.bottomCenter
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     )
    //   ),
    // );
  }
}
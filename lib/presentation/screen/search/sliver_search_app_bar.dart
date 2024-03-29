import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:muix_player/presentation/screen/search/search_result.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {

    @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppMuixTheme.background,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextButton(
          onPressed:() => showSearch(context: context, delegate: SearchResult()),
          child: Row(
            children: [
              const Icon(
                Icons.search,  
                color: Colors.white, 
                size: 30, 
                shadows: [
                  Shadow(blurRadius: 5, color: Colors.black26)],
              ),
              SizedBox(width: 10.w,),
              Text('Discover', style: AppMuixTheme.textUrbanistBold15,)
            ],
          )
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;
  
  @override
  // TODO: implement minExtent
  double get minExtent => 50;
  
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
  
}
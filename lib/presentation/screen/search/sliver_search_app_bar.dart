import 'package:flutter/material.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:provider/provider.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {

    @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final muixTheme = context.read<MuixTheme>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: BlurContainer(
        borderRadius: BorderRadius.circular(20),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Icon(
                Icons.search,  
                color: Colors.white, 
                size: 35,
                
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  cursorColor: muixTheme.colorWhite,
                  style: muixTheme.styleUrbanist24WhiteW500,
                  decoration: const InputDecoration(
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // TextButton(
        //   onPressed:() => showSearch(context: context, delegate: SearchResult()),
        //   child: Row(
        //     children: [
        //       const Icon(
        //         Icons.search,  
        //         color: Colors.white, 
        //         size: 30,
        //         shadows: [
        //           Shadow(blurRadius: 5, color: Colors.black26)],
        //       ),
        //       SizedBox(width: 10.w,),
        //       Text('Discover', style: muixTheme.styleUrbanist24WhiteW500,)
        //     ],
        //   )
        // ),
      ),
    );
  }

  @override
  double get maxExtent => 100;
  
  @override
  double get minExtent => 50;
  
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
  
}
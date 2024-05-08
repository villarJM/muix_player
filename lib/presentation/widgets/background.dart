import 'package:flutter/material.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class Background extends StatelessWidget {
const Background({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppMuixTheme.background,
                AppMuixTheme.background,
                AppMuixTheme.backgroundSecondary,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )
          ),
        ),
      ],
    );
  }
}
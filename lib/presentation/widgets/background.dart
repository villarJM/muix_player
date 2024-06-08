import 'package:flutter/material.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class Background extends StatelessWidget {
const Background({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            'assets/images/light.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
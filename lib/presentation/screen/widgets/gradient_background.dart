import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
const GradientBackground({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0XFF212345),
            Color(0XFF404094),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter
        )
      ),
    );
  }
}
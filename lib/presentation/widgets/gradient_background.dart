import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
const GradientBackground({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0XFFedf5f8),
            Color(0XFFedf5f8),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LinearGradientBackground extends StatelessWidget {

  final List<Color> colors;
  final List<double> stops;

  const LinearGradientBackground({ 
    super.key, 
    this.colors = const[
    Color.fromARGB(255, 27, 20, 85),
    Color(0X19194EFF)
    ],
    this.stops = const[0.0, 1.0]
    
  }): assert(colors.length == stops.length, 'Stops and Colors must be same length');

  @override
  Widget build(BuildContext context){
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            stops: stops,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
      ));
  }
}
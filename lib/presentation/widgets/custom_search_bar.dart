import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CustomSearchBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Construye el contenido del encabezado aquí
    return Container(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: GlassmorphicContainer(
            width: double.infinity,
            height: 60,
            borderRadius: 10,
            blur: 20,
            alignment: Alignment.bottomCenter,
            border: 1,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
                stops: const [
                  0.1,
                  1,
                ]),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0Xffffffff).withOpacity(0.5),
                const Color(0Xffffffff).withOpacity(0.0),
                const Color(0Xffffffff).withOpacity(0.0),
                const Color(0Xffffffff).withOpacity(0.5),
              ],
              
            ),
            child: const Center(child: Text("Search...")),
          ),
        ),
      );
  }

  @override
  double get maxExtent => 60.0; // Altura máxima del encabezado

  @override
  double get minExtent => 60.0; // Altura mínima del encabezado

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false; // Devuelve true si el encabezado debe reconstruirse cuando cambia
  }
}
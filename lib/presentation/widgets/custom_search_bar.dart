import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Construye el contenido del encabezado aquí
    return Container(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: const Text('Search...', style: TextStyle(color: Colors.white, fontSize: 18,),).frosted(
            height: 55,
            width: MediaQuery.of(context).size.width,
            borderRadius: BorderRadius.circular(5),
            blur: 2.5,
        ),
      )
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
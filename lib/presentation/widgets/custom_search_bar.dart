import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class CustomSearchBar extends SliverPersistentHeaderDelegate {

  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final TextEditingController textEditingController;

  CustomSearchBar({
    required this.onChanged,
    required this.onTap,
    required this.onEditingComplete,
    required this.textEditingController
  });
  
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Construye el contenido del encabezado aquí
    return Container(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: GlassContainer(
            width: MediaQuery.of(context).size.width,
            height: 70,
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(13),
            borderGradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.39, 0.40, 1.0],
            ),
            blur: 15.0,
            borderWidth: 1,
            elevation: 3.0,
            isFrostedGlass: true,
            shadowColor: Colors.black.withOpacity(0.50),
            alignment: Alignment.center,
            frostedOpacity: 0.01,
            child: Center(
              child: TextField(
                controller: textEditingController,
                onChanged: onChanged,
                onTap: onTap,
                onEditingComplete: onEditingComplete,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: const TextStyle(overflow: TextOverflow.fade),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  
                ),
              )
            ),
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
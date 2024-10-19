import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';

final navigationItem = <NavigationDestination> [

    const NavigationDestination(
      label: 'Home',
      icon: Iconify(
        Bi.grid_fill,
        color: Colors.white,
      ),
      selectedIcon: Iconify(
        Bi.grid_fill,
      ),
    ),
    const NavigationDestination(
      label: 'Search',
      icon: Iconify(
        Ri.search_2_fill,
        color: Colors.white,
      ),
      selectedIcon: Iconify(
        Ri.search_2_fill,
      ),
    ),
    const NavigationDestination(
      label: 'Library',
      icon: Icon(
        FluentIcons.library_20_filled,
        color: Colors.white,
      ),
      selectedIcon: Icon(
        FluentIcons.library_20_filled,
      ),
    ),
  ];
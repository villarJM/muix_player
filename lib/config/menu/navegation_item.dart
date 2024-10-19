import 'package:flutter/material.dart';
import 'package:muix_player/helper/icons.dart';

final navigationItem = <NavegationItem>[

    const NavegationItem(
      pageIndex: 0,
      label: 'Home',
      icon: Iconify(
        Bi.grid_fill,
        color: Colors.white,
        size: 40,
      ),
      selectedIcon: Iconify(
        Bi.grid_fill,
        size: 40,
      ),
    ),
    const NavegationItem(
      pageIndex: 1,
      label: 'Search',
      icon: Iconify(
        Ri.search_2_fill,
        color: Colors.white,
        size: 40,
      ),
      selectedIcon: Iconify(
        Ri.search_2_fill,
        size: 40,
      ),
    ),
    const NavegationItem(
      pageIndex: 2,
      label: 'Library',
      icon: Icon(
        FluentIcons.library_20_filled,
        color: Colors.white,
        size: 40,
      ),
      selectedIcon: Icon(
        FluentIcons.library_20_filled,
        size: 40,
        color: Colors.black,
      ),
    ),
  ];

  class NavegationItem {
    final String label;
    final Widget icon;
    final Widget selectedIcon;
    final int pageIndex;

    const NavegationItem({
      required this.label, 
      required this.icon, 
      required this.selectedIcon, 
      required this.pageIndex
    });
  }
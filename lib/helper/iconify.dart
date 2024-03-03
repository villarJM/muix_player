import 'package:flutter/material.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

  final navigationItem = <NavigationDestination> [
    const NavigationDestination(
      selectedIcon: Iconify(
        Bi.grid_fill, 
        color: Colors.white,
      ),
      icon: Iconify(
        Bi.grid_fill,
        color: Colors.black,
      ),
      label: 'Home',
    ),
    const NavigationDestination(
      selectedIcon: Iconify(
        Ri.search_2_fill, 
        color: Colors.white,
      ),
      icon: Iconify(
        Ri.search_2_fill,
        color: Colors.black,
      ),
      label: 'Search',
    ),
    const NavigationDestination(
      selectedIcon: Icon(
        FluentIcons.library_20_filled, 
        color: Colors.white,
      ),
      icon: Icon(
        FluentIcons.library_20_filled,
        color: Colors.black,
      ),
      label: 'Messages',
    ),
  ];
  
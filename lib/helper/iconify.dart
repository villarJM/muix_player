import 'package:flutter/material.dart';

import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

  final navigationItem = <NavigationDestination> [

    NavigationDestination(
      label: 'Home',
      icon: const Iconify(
        Bi.grid_fill,
        color: Colors.white,
      ),
      selectedIcon: Iconify(
        Bi.grid_fill,
        color: AppMuixTheme.primary,
      ),
    ),
    NavigationDestination(
      label: 'Search',
      icon: const Iconify(
        Ri.search_2_fill,
        color: Colors.white,
      ),
      selectedIcon: Iconify(
        Ri.search_2_fill,
        color: AppMuixTheme.primary,
      ),
    ),
    NavigationDestination(
      label: 'Library',
      icon: const Icon(
        FluentIcons.library_20_filled,
        color: Colors.white,
      ),
      selectedIcon: Icon(
        FluentIcons.library_20_filled,
        color: AppMuixTheme.primary,
      ),
    ),
  ];
  
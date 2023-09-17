import 'package:flutter/material.dart';

class MenuItems {
  final String title;
  final String link;
  final IconData icon;

  const MenuItems({
    required this.title, 
    required this.link, 
    required this.icon
});
}

const appMenuItems = <MenuItems> [
  MenuItems(
    title: 'All the songs', 
    link: '/all-songs', 
    icon: Icons.music_note
  ),
];
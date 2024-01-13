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
  // MenuItems(
  //   title: 'Transform 3D', 
  //   link: '/transform-3d', 
  //   icon: Icons.play_arrow_outlined,
  // ),
  MenuItems(
    title: 'Playing now', 
    link: '/playing-now', 
    icon: Icons.play_arrow_outlined,
  ),
  MenuItems(
    title: 'Dashboard', 
    link: '/', 
    icon: Icons.border_all,
  ),
  MenuItems(
    title: 'All the songs', 
    link: '/all-songs', 
    icon: Icons.music_note_outlined,
  ),
  MenuItems(
    title: 'Albums', 
    link: '/albums', 
    icon: Icons.disc_full,
  ),
  MenuItems(
    title: 'Artist', 
    link: '/artist', 
    icon: Icons.mic_rounded,
  ),
  MenuItems(
    title: 'Genders', 
    link: '/genders', 
    icon: Icons.library_music,
  ),
  MenuItems(
    title: 'Playlist', 
    link: '/playlist', 
    icon: Icons.playlist_play_outlined,
  ),
];
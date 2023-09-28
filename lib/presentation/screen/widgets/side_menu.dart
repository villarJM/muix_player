import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:muix_player/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.scaffoldKey,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    return ClipRRect(
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border.all(color: const Color.fromARGB(255, 114, 114, 114)),
            gradient: LinearGradient(
              colors: [
                const Color(0XFF404094).withOpacity(0.1),
                const Color(0XFF4B0440).withOpacity(1.0)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: NavigationDrawer(
            backgroundColor: const Color.fromARGB(52, 255, 255, 255),
            selectedIndex: navDrawerIndex,
            indicatorShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            elevation: 0.1,
            indicatorColor: const Color(0XFF4B0440).withOpacity(0.7),
            onDestinationSelected: (value) {
              setState(() {
                navDrawerIndex = value;
              });
        
              final menuItem = appMenuItems[value];
              context.push(menuItem.link);
              widget.scaffoldKey.currentState?.closeDrawer();
            },
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(28, hasNotch ? 5 : 20, 16, 10),
                child: const Text('Main'),
              ),
              
              ...appMenuItems
                .sublist(0,7)
                .map((item) => NavigationDrawerDestination(
                  icon: Icon(item.icon, color: Colors.white), 
                  label: Text(item.title, style: const TextStyle(color: Colors.white),)
                  ),
                ),
        
                const Padding(
                  padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                  child: Divider(),
                ),
        
                // const Padding(
                //   padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
                //   child: Text('More  option'),
                // ),
                // ...appMenuItems
                // .sublist(0)
                // .map((item) => NavigationDrawerDestination(
                //   icon: Icon(item.icon), 
                //   label: Text(item.title)
                //   ),
                // ),
            ],
          ),
        ),
      ),
    );
  }
}

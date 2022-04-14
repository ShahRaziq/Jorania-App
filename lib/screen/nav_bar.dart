import 'dart:ffi';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:Jorania/custom/weatherCard.dart';
import 'package:Jorania/screen/favorite.dart';
import 'package:Jorania/screen/homepage.dart';
import 'package:Jorania/screen/list_service.dart';
import 'package:Jorania/screen/login_screen.dart';
import 'package:Jorania/screen/map.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var _selectedIndex = 0;
  final screens = [
    HomePage(),
    MapPage(),
    FavoritePage(),
    ListServicePage(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Color(0xffFE8C48), curve: Curves.linear,
          //bottom nav bar
          containerHeight: 70, //container height
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              title: Text('  Utama'),
              activeColor: Color(0xff414141),
            ),
            BottomNavyBarItem(
                icon: Icon(
                  Icons.anchor,
                  size: 30,
                ),
                title: Text('   Peta'),
                activeColor: Color(0xff414141)),
            BottomNavyBarItem(
                icon: Icon(
                  Icons.star,
                  size: 32,
                ),
                title: Text('Kegemaran'),
                activeColor: Color(0xff414141)),
            BottomNavyBarItem(
                icon: Icon(
                  Icons.store,
                  size: 30,
                ),
                title: Text('   Servis'),
                activeColor: Color(0xff414141)),
          ],
        ),
      );
}

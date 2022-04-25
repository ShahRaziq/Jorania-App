import 'package:Jorania/providers/place_provider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:Jorania/screen/favorite.dart';
import 'package:Jorania/screen/homepage.dart';
import 'package:Jorania/screen/list_service.dart';
import 'package:Jorania/screen/map.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var _selectedIndex = 0;
  final screens = [
    const HomePage(),
    const MapPage(),
    const FavoritePage(),
    const ListServicePage(),
  ];

  @override
  initState() {
    super.initState();
  }

  PageController pageController = PageController();
// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);
    place.place = widget;
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          _selectedIndex = value;
          setState(() {});
        },
        controller: pageController,
        children: screens,
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: const Color(0xffFE8C48),
        curve: Curves.linear,
        //bottom nav bar
        containerHeight: 70, //container height
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          pageController.animateToPage(_selectedIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(
              Icons.home,
              size: 30,
            ),
            title: const Text('  Utama'),
            inactiveColor: const Color.fromARGB(255, 99, 98, 98),
            activeColor: const Color(0xff414141),
          ),
          BottomNavyBarItem(
            icon: const Icon(
              Icons.anchor,
              size: 30,
            ),
            title: const Text('   Peta'),
            inactiveColor: const Color.fromARGB(255, 99, 98, 98),
            activeColor: const Color(0xff414141),
          ),
          BottomNavyBarItem(
            icon: const Icon(
              Icons.star,
              size: 32,
            ),
            title: const Text('Kegemaran'),
            inactiveColor: const Color.fromARGB(255, 99, 98, 98),
            activeColor: const Color(0xff414141),
          ),
          BottomNavyBarItem(
            icon: const Icon(
              Icons.store,
              size: 30,
            ),
            title: const Text('   Servis'),
            inactiveColor: const Color.fromARGB(255, 99, 98, 98),
            activeColor: const Color(0xff414141),
          ),
        ],
      ),
    );
  }
}

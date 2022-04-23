import 'package:Jorania/providers/place_provider.dart';
import 'package:Jorania/screen/noConnection_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  var subscription;
  var _selectedIndex = 0;
  final screens = [
    HomePage(),
    MapPage(),
    FavoritePage(),
    ListServicePage(),
  ];

  @override
  initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result != ConnectivityResult.none) {
        Navigator.push(context, MaterialPageRoute(builder: (c) => NavBar()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => NoConScreen()));
      }
    });
  }

  PageController pageController = PageController();
// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);
    place.place = widget;
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          _selectedIndex = value;
          setState(() {});
        },
        controller: pageController,
        children: screens,
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xffFE8C48),
        curve: Curves.linear,
        //bottom nav bar
        containerHeight: 70, //container height
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          pageController.animateToPage(_selectedIndex,
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            title: Text('  Utama'),
            inactiveColor: Color.fromARGB(255, 99, 98, 98),
            activeColor: Color(0xff414141),
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.anchor,
              size: 30,
            ),
            title: Text('   Peta'),
            inactiveColor: Color.fromARGB(255, 99, 98, 98),
            activeColor: Color(0xff414141),
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.star,
              size: 32,
            ),
            title: Text('Kegemaran'),
            inactiveColor: Color.fromARGB(255, 99, 98, 98),
            activeColor: Color(0xff414141),
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.store,
              size: 30,
            ),
            title: Text('   Servis'),
            inactiveColor: Color.fromARGB(255, 99, 98, 98),
            activeColor: Color(0xff414141),
          ),
        ],
      ),
    );
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          _selectedIndex = value;
          setState(() {});
        },
        controller: pageController,
        children: screens,
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xffFE8C48),
        curve: Curves.linear,
        //bottom nav bar
        containerHeight: 70, //container height
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          pageController.animateToPage(_selectedIndex,
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            title: Text('  Utama'),
            inactiveColor: Color.fromARGB(255, 99, 98, 98),
            activeColor: Color(0xff414141),
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.anchor,
              size: 30,
            ),
            title: Text('   Peta'),
            inactiveColor: Color.fromARGB(255, 99, 98, 98),
            activeColor: Color(0xff414141),
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.star,
              size: 32,
            ),
            title: Text('Kegemaran'),
            inactiveColor: Color.fromARGB(255, 99, 98, 98),
            activeColor: Color(0xff414141),
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.store,
              size: 30,
            ),
            title: Text('   Servis'),
            inactiveColor: Color.fromARGB(255, 99, 98, 98),
            activeColor: Color(0xff414141),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'home_screen.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';




class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}




class _ProductScreenState extends State<ProductScreen> {

  //State Variables
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;

  //Navigation Targets
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];


  //Navigation Handler
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  //Navigation Bar Icons
  final List<Widget> _navItems = [
    Icon(Icons.home, size: 30, color: Colors.white),
    Icon(Icons.search, size: 30, color: Colors.white),
    Icon(Icons.shopping_cart, size: 30, color: Colors.white),
    Icon(Icons.person, size: 30, color: Colors.white),
  ];



  //UI part
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // makes it look smoother with floating nav
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _selectedIndex,
        height: 60.0,
        items: _navItems,
        color: Color(0xFFFF4F40), // changed color to #FF4F40
        buttonBackgroundColor: Color(0xFFFF4F40), // changed color to #FF4F40
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: _onTap,
        letIndexChange: (index) => true,
      ),
    );
  }
}

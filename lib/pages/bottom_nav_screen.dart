import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import 'orders_page.dart';
import 'profile_page.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List<Widget> _pages = [HomePage(), OrdersPage(), ProfilePage()];
  final List<String> _pagesTitles = ["Home Page", "Orders", "Profile"];

  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagesTitles[_currentTabIndex]),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: Colors.black,
        backgroundColor:
            _currentTabIndex == 0 ? HOME_PAGE_BACKGROUND_COLOR : Colors.white,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        animationDuration: Duration(milliseconds: 400),
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outlined,
            color: Colors.white,
          ),
        ],
      ),
      body: _pages[_currentTabIndex],
    );
  }
}

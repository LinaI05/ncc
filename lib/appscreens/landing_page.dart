import 'package:flutter/material.dart';
import 'package:ncc/appscreens/hotlines_page.dart';
import 'settings_page.dart';
import 'home_page.dart';
import 'activities_page.dart';
import 'copingplans_page.dart';
import 'achieve_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class LandingPage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      homePage(),
      ActivitiesPage(),
      copingPlansPage(),
      achievePage(),
      hotlinePage(),
      settingsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Color(0xFF115D6C),
        inactiveColorPrimary: Color(0xFF93D1DE),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.toc),
        title: 'Activities',
        activeColorPrimary: Color(0xFF115D6C),
        inactiveColorPrimary: Color(0xFF93D1DE),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_month_outlined),
        title: 'Coping Plans',
        activeColorPrimary: Color(0xFF115D6C),
        inactiveColorPrimary: Color(0xFF93D1DE),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.emoji_events),
        title: 'Achievements',
        activeColorPrimary: Color(0xFF115D6C),
        inactiveColorPrimary: Color(0xFF93D1DE),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.phone),
        title: 'Hotlines',
        activeColorPrimary: Color(0xFF115D6C),
        inactiveColorPrimary: Color(0xFF93D1DE),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: 'Settings',
        activeColorPrimary: Color(0xFF115D6C),
        inactiveColorPrimary: Color(0xFF93D1DE),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style13,
      stateManagement: false,
      onItemSelected: (index) {
        setState(() {
          _controller.index = index;
        });
      },
    );
  }
}

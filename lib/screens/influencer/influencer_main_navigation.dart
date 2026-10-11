import 'package:flutter/material.dart';

import 'alerts_screen.dart';
import 'influencer_home_screen.dart';
import 'influencer_profile_screen.dart';
import 'my_applications_screen.dart';

class InfluencerMainNavigation extends StatefulWidget {
  final int initialIndex;

  const InfluencerMainNavigation({super.key, this.initialIndex = 0});

  @override
  State<InfluencerMainNavigation> createState() =>
      _InfluencerMainNavigationState();
}

class _InfluencerMainNavigationState extends State<InfluencerMainNavigation> {
  late int _currentIndex;
  static const Color primaryPurple = Color(0xFF7C3AED);

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      InfluencerHomeScreen(onNavigateTab: switchTab),
      const MyApplicationsScreen(),
      const AlertsScreen(),
      const InfluencerProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFEAECF0), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryPurple,
          unselectedItemColor: const Color(0xFF98A2B3),
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline_rounded),
              activeIcon: Icon(Icons.work_rounded),
              label: 'Applications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded),
              activeIcon: Icon(Icons.notifications_rounded),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

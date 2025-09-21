import 'package:easyhealth/pages/booking_screen.dart';
import 'package:easyhealth/pages/home_screen.dart';
import 'package:easyhealth/pages/notif_screen.dart';
import 'package:easyhealth/pages/profile_screen.dart';
import 'package:easyhealth/pages/search_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainPage();
}

class _MainPage extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screenOptions = <Widget>[
    HomeScreen(),
    BookingScreen(),
    SearchScreen(),
    NotifScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // item pertama
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifikasi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: "Profile",
          ),
          // item ketiga
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}

import 'package:easyhealth/screens/chatlist_screen.dart';
import 'package:easyhealth/widgets/bottom_navigation.dart';
import 'package:easyhealth/screens/booking_screen.dart';
import 'package:easyhealth/screens/home_screen.dart';
import 'package:easyhealth/screens/notif_screen.dart';
import 'package:easyhealth/screens/profile_screen.dart';
import 'package:easyhealth/screens/search_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  final Widget? screen;
  const MainScreen({super.key, this.index, this.screen});

  @override
  State<MainScreen> createState() => _MainPage();
}

class _MainPage extends State<MainScreen> {
  int _selectedIndex = 0;
  Widget? _customScreen;
  String role = "Admin";
  late List<Widget> _screenOptions;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? _selectedIndex; // isi setelah state dibuat
    _customScreen = widget.screen;

    _screenOptions = [
      HomeScreen(),
      BookingScreen(),
      SearchScreen(),
      role == "Admin" ? ChatListScreen() : NotifScreen(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _customScreen = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _customScreen ?? _screenOptions.elementAt(_selectedIndex),
      bottomNavigationBar: ButtonNavBar(
        role: role,
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

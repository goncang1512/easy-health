import 'package:flutter/material.dart';

class ButtonNavBar extends StatefulWidget {
  final Function(int)? onItemTapped;
  final int selectedIndex;
  const ButtonNavBar({super.key, this.onItemTapped, this.selectedIndex = 0});

  @override
  State<ButtonNavBar> createState() => _BottomComponent();
}

class _BottomComponent extends State<ButtonNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
    );
  }
}

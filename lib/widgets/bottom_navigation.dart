import 'package:flutter/material.dart';

class ButtonNavBar extends StatelessWidget {
  final Function(int)? onItemTapped;
  final int selectedIndex;
  final String role;
  const ButtonNavBar({
    super.key,
    this.onItemTapped,
    this.selectedIndex = 0,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        // item pertama
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
        const BottomNavigationBarItem(icon: Icon(Icons.list), label: "Booking"),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Pencarian",
        ),
        BottomNavigationBarItem(
          icon: Icon(role == "Admin" ? Icons.message : Icons.notifications),
          label: role == "Admin" ? "Pesan" : "Notifikasi",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle),
          label: "Profil",
        ),
        // item ketiga
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
    );
  }
}

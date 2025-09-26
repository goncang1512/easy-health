import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonNavBar extends StatelessWidget {
  final String role;
  final StatefulNavigationShell? navigationShell;
  const ButtonNavBar({super.key, required this.role, this.navigationShell});

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
      currentIndex: navigationShell?.currentIndex ?? 0,
      onTap: (index) {
        final navigationShell = this.navigationShell;
        if (navigationShell != null) {
          navigationShell.goBranch(index);
        } else {
          context.go("/");
        }
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
    );
  }
}

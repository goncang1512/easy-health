import 'package:easyhealth/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/routes.dart';

class BottomNavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final String role;

  const BottomNavigationShell({
    super.key,
    required this.navigationShell,
    required this.role,
  });

  void _onItemTapped(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final currentIndex = navigationShell.currentIndex;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;

        final String currentLocation = GoRouterState.of(context).uri.path;

        if (currentLocation == AppRoutes.home) {
          Navigator.of(context).pop();
        } else {
          if (GoRouter.of(context).canPop()) {
            GoRouter.of(context).pop();
          } else {
            context.go(AppRoutes.home);
          }
        }
      },
      child: Container(
        height: MediaQuery.of(context).padding.bottom + screenHeight * 0.070,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              0,
              Icons.home_rounded,
              'Beranda',
              currentIndex,
              screenWidth,
              screenHeight,
            ),
            _buildNavItem(
              context,
              1,
              Icons.list,
              role == "Admin" ? "Dokter" : 'Booking',
              currentIndex,
              screenWidth,
              screenHeight,
            ),
            _buildNavItem(
              context,
              2,
              role == "Admin" ? Icons.message : Icons.search,
              role == "Admin" ? "Pesan" : 'Pencarian',
              currentIndex,
              screenWidth,
              screenHeight,
            ),
            _buildNavItem(
              context,
              3,
              Icons.notifications,
              "Kotak Masuk",
              currentIndex,
              screenWidth,
              screenHeight,
            ),
            _buildNavItem(
              context,
              4,
              Icons.person_rounded,
              'Profil',
              currentIndex,
              screenWidth,
              screenHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
    int currentIndex,
    double screenWidth,
    double screenHeight,
  ) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.025,
          horizontal: screenWidth * 0.025,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? ThemeColors.primary : Colors.black,
              size: screenWidth * 0.06,
            ),
            Text(
              label,
              style: TextStyle(
                color: isActive ? ThemeColors.primary : Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
